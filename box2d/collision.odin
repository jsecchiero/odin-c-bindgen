// SPDX-FileCopyrightText: 2023 Erin Catto
// SPDX-License-Identifier: MIT
package box2d

foreign import lib "box2d.lib"
_ :: lib

/**
* @defgroup geometry Geometry
* @brief Geometry types and algorithms
*
* Definitions of circles, capsules, segments, and polygons. Various algorithms to compute hulls, mass properties, and so on.
* @{
*/

/// The maximum number of vertices on a convex polygon. Changing this affects performance even if you
/// don't use more vertices.
MAX_POLYGON_VERTICES :: 8

/// Low level ray cast input data
Ray_Cast_Input :: struct {
	/// Start point of the ray cast
	origin: Vec2,

	/// Translation of the ray cast
	translation: Vec2,

	/// The maximum fraction of the translation to consider, typically 1
	maxFraction: f32,
}

/// Low level shape cast input in generic form. This allows casting an arbitrary point
/// cloud wrap with a radius. For example, a circle is a single point with a non-zero radius.
/// A capsule is two points with a non-zero radius. A box is four points with a zero radius.
Shape_Cast_Input :: struct {
	/// A point cloud to cast
	points: [8]Vec2,

	/// The number of points
	count: i32,

	/// The radius around the point cloud
	radius: f32,

	/// The translation of the shape cast
	translation: Vec2,

	/// The maximum fraction of the translation to consider, typically 1
	maxFraction: f32,
}

/// Low level ray cast or shape-cast output data
Cast_Output :: struct {
	/// The surface normal at the hit point
	normal: Vec2,

	/// The surface hit point
	point: Vec2,

	/// The fraction of the input translation at collision
	fraction: f32,

	/// The number of iterations used
	iterations: i32,

	/// Did the cast hit?
	hit: bool,
}

/// This holds the mass data computed for a shape.
Mass_Data :: struct {
	/// The mass of the shape, usually in kilograms.
	mass: f32,

	/// The position of the shape's centroid relative to the shape's origin.
	center: Vec2,

	/// The rotational inertia of the shape about the local origin.
	rotationalInertia: f32,
}

/// A solid circle
Circle :: struct {
	/// The local center
	center: Vec2,

	/// The radius
	radius: f32,
}

/// A solid capsule can be viewed as two semicircles connected
/// by a rectangle.
Capsule :: struct {
	/// Local center of the first semicircle
	center1: Vec2,

	/// Local center of the second semicircle
	center2: Vec2,

	/// The radius of the semicircles
	radius: f32,
}

/// A solid convex polygon. It is assumed that the interior of the polygon is to
/// the left of each edge.
/// Polygons have a maximum number of vertices equal to B2_MAX_POLYGON_VERTICES.
/// In most cases you should not need many vertices for a convex polygon.
/// @warning DO NOT fill this out manually, instead use a helper function like
/// b2MakePolygon or b2MakeBox.
Polygon :: struct {
	/// The polygon vertices
	vertices: [8]Vec2,

	/// The outward normal vectors of the polygon sides
	normals: [8]Vec2,

	/// The centroid of the polygon
	centroid: Vec2,

	/// The external radius for rounded polygons
	radius: f32,

	/// The number of polygon vertices
	count: i32,
}

/// A line segment with two-sided collision.
Segment :: struct {
	/// The first point
	point1: Vec2,

	/// The second point
	point2: Vec2,
}

/// A line segment with one-sided collision. Only collides on the right side.
/// Several of these are generated for a chain shape.
/// ghost1 -> point1 -> point2 -> ghost2
Chain_Segment :: struct {
	/// The tail ghost vertex
	ghost1: Vec2,

	/// The line segment
	segment: Segment,

	/// The head ghost vertex
	ghost2: Vec2,

	/// The owning chain shape index (internal usage only)
	chainId: i32,
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Validate ray cast input data (NaN, etc)
	@(link_name="b2IsValidRay")
	is_valid_ray :: proc(input: ^Ray_Cast_Input) -> bool ---

	/// Make a convex polygon from a convex hull. This will assert if the hull is not valid.
	/// @warning Do not manually fill in the hull data, it must come directly from b2ComputeHull
	@(link_name="b2MakePolygon")
	make_polygon :: proc(hull: ^Hull, radius: f32) -> Polygon ---

	/// Make an offset convex polygon from a convex hull. This will assert if the hull is not valid.
	/// @warning Do not manually fill in the hull data, it must come directly from b2ComputeHull
	@(link_name="b2MakeOffsetPolygon")
	make_offset_polygon :: proc(hull: ^Hull, position: Vec2, rotation: Rot) -> Polygon ---

	/// Make an offset convex polygon from a convex hull. This will assert if the hull is not valid.
	/// @warning Do not manually fill in the hull data, it must come directly from b2ComputeHull
	@(link_name="b2MakeOffsetRoundedPolygon")
	make_offset_rounded_polygon :: proc(hull: ^Hull, position: Vec2, rotation: Rot, radius: f32) -> Polygon ---

	/// Make a square polygon, bypassing the need for a convex hull.
	/// @param halfWidth the half-width
	@(link_name="b2MakeSquare")
	make_square :: proc(halfWidth: f32) -> Polygon ---

	/// Make a box (rectangle) polygon, bypassing the need for a convex hull.
	/// @param halfWidth the half-width (x-axis)
	/// @param halfHeight the half-height (y-axis)
	@(link_name="b2MakeBox")
	make_box :: proc(halfWidth: f32, halfHeight: f32) -> Polygon ---

	/// Make a rounded box, bypassing the need for a convex hull.
	/// @param halfWidth the half-width (x-axis)
	/// @param halfHeight the half-height (y-axis)
	/// @param radius the radius of the rounded extension
	@(link_name="b2MakeRoundedBox")
	make_rounded_box :: proc(halfWidth: f32, halfHeight: f32, radius: f32) -> Polygon ---

	/// Make an offset box, bypassing the need for a convex hull.
	/// @param halfWidth the half-width (x-axis)
	/// @param halfHeight the half-height (y-axis)
	/// @param center the local center of the box
	/// @param rotation the local rotation of the box
	@(link_name="b2MakeOffsetBox")
	make_offset_box :: proc(halfWidth: f32, halfHeight: f32, center: Vec2, rotation: Rot) -> Polygon ---

	/// Make an offset rounded box, bypassing the need for a convex hull.
	/// @param halfWidth the half-width (x-axis)
	/// @param halfHeight the half-height (y-axis)
	/// @param center the local center of the box
	/// @param rotation the local rotation of the box
	/// @param radius the radius of the rounded extension
	@(link_name="b2MakeOffsetRoundedBox")
	make_offset_rounded_box :: proc(halfWidth: f32, halfHeight: f32, center: Vec2, rotation: Rot, radius: f32) -> Polygon ---

	/// Transform a polygon. This is useful for transferring a shape from one body to another.
	@(link_name="b2TransformPolygon")
	transform_polygon :: proc(transform: Transform, polygon: ^Polygon) -> Polygon ---

	/// Compute mass properties of a circle
	@(link_name="b2ComputeCircleMass")
	compute_circle_mass :: proc(shape: ^Circle, density: f32) -> Mass_Data ---

	/// Compute mass properties of a capsule
	@(link_name="b2ComputeCapsuleMass")
	compute_capsule_mass :: proc(shape: ^Capsule, density: f32) -> Mass_Data ---

	/// Compute mass properties of a polygon
	@(link_name="b2ComputePolygonMass")
	compute_polygon_mass :: proc(shape: ^Polygon, density: f32) -> Mass_Data ---

	/// Compute the bounding box of a transformed circle
	@(link_name="b2ComputeCircleAABB")
	compute_circle_aabb :: proc(shape: ^Circle, transform: Transform) -> Aabb ---

	/// Compute the bounding box of a transformed capsule
	@(link_name="b2ComputeCapsuleAABB")
	compute_capsule_aabb :: proc(shape: ^Capsule, transform: Transform) -> Aabb ---

	/// Compute the bounding box of a transformed polygon
	@(link_name="b2ComputePolygonAABB")
	compute_polygon_aabb :: proc(shape: ^Polygon, transform: Transform) -> Aabb ---

	/// Compute the bounding box of a transformed line segment
	@(link_name="b2ComputeSegmentAABB")
	compute_segment_aabb :: proc(shape: ^Segment, transform: Transform) -> Aabb ---

	/// Test a point for overlap with a circle in local space
	@(link_name="b2PointInCircle")
	point_in_circle :: proc(point: Vec2, shape: ^Circle) -> bool ---

	/// Test a point for overlap with a capsule in local space
	@(link_name="b2PointInCapsule")
	point_in_capsule :: proc(point: Vec2, shape: ^Capsule) -> bool ---

	/// Test a point for overlap with a convex polygon in local space
	@(link_name="b2PointInPolygon")
	point_in_polygon :: proc(point: Vec2, shape: ^Polygon) -> bool ---

	/// Ray cast versus circle shape in local space. Initial overlap is treated as a miss.
	@(link_name="b2RayCastCircle")
	ray_cast_circle :: proc(input: ^Ray_Cast_Input, shape: ^Circle) -> Cast_Output ---

	/// Ray cast versus capsule shape in local space. Initial overlap is treated as a miss.
	@(link_name="b2RayCastCapsule")
	ray_cast_capsule :: proc(input: ^Ray_Cast_Input, shape: ^Capsule) -> Cast_Output ---

	/// Ray cast versus segment shape in local space. Optionally treat the segment as one-sided with hits from
	/// the left side being treated as a miss.
	@(link_name="b2RayCastSegment")
	ray_cast_segment :: proc(input: ^Ray_Cast_Input, shape: ^Segment, oneSided: bool) -> Cast_Output ---

	/// Ray cast versus polygon shape in local space. Initial overlap is treated as a miss.
	@(link_name="b2RayCastPolygon")
	ray_cast_polygon :: proc(input: ^Ray_Cast_Input, shape: ^Polygon) -> Cast_Output ---

	/// Shape cast versus a circle. Initial overlap is treated as a miss.
	@(link_name="b2ShapeCastCircle")
	shape_cast_circle :: proc(input: ^Shape_Cast_Input, shape: ^Circle) -> Cast_Output ---

	/// Shape cast versus a capsule. Initial overlap is treated as a miss.
	@(link_name="b2ShapeCastCapsule")
	shape_cast_capsule :: proc(input: ^Shape_Cast_Input, shape: ^Capsule) -> Cast_Output ---

	/// Shape cast versus a line segment. Initial overlap is treated as a miss.
	@(link_name="b2ShapeCastSegment")
	shape_cast_segment :: proc(input: ^Shape_Cast_Input, shape: ^Segment) -> Cast_Output ---

	/// Shape cast versus a convex polygon. Initial overlap is treated as a miss.
	@(link_name="b2ShapeCastPolygon")
	shape_cast_polygon :: proc(input: ^Shape_Cast_Input, shape: ^Polygon) -> Cast_Output ---
}

/// A convex hull. Used to create convex polygons.
/// @warning Do not modify these values directly, instead use b2ComputeHull()
Hull :: struct {
	/// The final points of the hull
	points: [8]Vec2,

	/// The number of points
	count: i32,
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Compute the convex hull of a set of points. Returns an empty hull if it fails.
	/// Some failure cases:
	/// - all points very close together
	/// - all points on a line
	/// - less than 3 points
	/// - more than B2_MAX_POLYGON_VERTICES points
	/// This welds close points and removes collinear points.
	/// @warning Do not modify a hull once it has been computed
	@(link_name="b2ComputeHull")
	compute_hull :: proc(points: ^Vec2, count: i32) -> Hull ---

	/// This determines if a hull is valid. Checks for:
	/// - convexity
	/// - collinear points
	/// This is expensive and should not be called at runtime.
	@(link_name="b2ValidateHull")
	validate_hull :: proc(hull: ^Hull) -> bool ---
}

/// Result of computing the distance between two line segments
Segment_Distance_Result :: struct {
	/// The closest point on the first segment
	closest1: Vec2,

	/// The closest point on the second segment
	closest2: Vec2,

	/// The barycentric coordinate on the first segment
	fraction1: f32,

	/// The barycentric coordinate on the second segment
	fraction2: f32,

	/// The squared distance between the closest points
	distanceSquared: f32,
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Compute the distance between two line segments, clamping at the end points if needed.
	@(link_name="b2SegmentDistance")
	segment_distance :: proc(p1: Vec2, q1: Vec2, p2: Vec2, q2: Vec2) -> Segment_Distance_Result ---
}

/// A distance proxy is used by the GJK algorithm. It encapsulates any shape.
Shape_Proxy :: struct {
	/// The point cloud
	points: [8]Vec2,

	/// The number of points
	count: i32,

	/// The external radius of the point cloud
	radius: f32,
}

/// Used to warm start the GJK simplex. If you call this function multiple times with nearby
/// transforms this might improve performance. Otherwise you can zero initialize this.
/// The distance cache must be initialized to zero on the first call.
/// Users should generally just zero initialize this structure for each call.
Simplex_Cache :: struct {
	/// The number of stored simplex points
	count: u16,

	/// The cached simplex indices on shape A
	indexA: [3]u8,

	/// The cached simplex indices on shape B
	indexB: [3]u8,
}

/// Input for b2ShapeDistance
Distance_Input :: struct {
	/// The proxy for shape A
	proxyA: Shape_Proxy,

	/// The proxy for shape B
	proxyB: Shape_Proxy,

	/// The world transform for shape A
	transformA: Transform,

	/// The world transform for shape B
	transformB: Transform,

	/// Should the proxy radius be considered?
	useRadii: bool,
}

/// Output for b2ShapeDistance
Distance_Output :: struct {
	pointA:       Vec2, ///< Closest point on shapeA
	pointB:       Vec2, ///< Closest point on shapeB
	distance:     f32,  ///< The final distance, zero if overlapped
	iterations:   i32,  ///< Number of GJK iterations used
	simplexCount: i32,  ///< The number of simplexes stored in the simplex array
}

/// Simplex vertex for debugging the GJK algorithm
Simplex_Vertex :: struct {
	wA:     Vec2, ///< support point in proxyA
	wB:     Vec2, ///< support point in proxyB
	w:      Vec2, ///< wB - wA
	a:      f32,  ///< barycentric coordinate for closest point
	indexA: i32,  ///< wA index
	indexB: i32,  ///< wB index
}

/// Simplex from the GJK algorithm
Simplex :: struct {
	v1, v2, v3: Simplex_Vertex, ///< vertices
	count:      i32,            ///< number of valid vertices
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Compute the closest points between two shapes represented as point clouds.
	/// b2SimplexCache cache is input/output. On the first call set b2SimplexCache.count to zero.
	/// The underlying GJK algorithm may be debugged by passing in debug simplexes and capacity. You may pass in NULL and 0 for these.
	@(link_name="b2ShapeDistance")
	shape_distance :: proc(cache: ^Simplex_Cache, input: ^Distance_Input, simplexes: ^Simplex, simplexCapacity: i32) -> Distance_Output ---
}

/// Input parameters for b2ShapeCast
Shape_Cast_Pair_Input :: struct {
	proxyA:       Shape_Proxy, ///< The proxy for shape A
	proxyB:       Shape_Proxy, ///< The proxy for shape B
	transformA:   Transform,   ///< The world transform for shape A
	transformB:   Transform,   ///< The world transform for shape B
	translationB: Vec2,        ///< The translation of shape B
	maxFraction:  f32,         ///< The fraction of the translation to consider, typically 1
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Perform a linear shape cast of shape B moving and shape A fixed. Determines the hit point, normal, and translation fraction.
	@(link_name="b2ShapeCast")
	shape_cast :: proc(input: ^Shape_Cast_Pair_Input) -> Cast_Output ---

	/// Make a proxy for use in GJK and related functions.
	@(link_name="b2MakeProxy")
	make_proxy :: proc(vertices: ^Vec2, count: i32, radius: f32) -> Shape_Proxy ---
}

/// This describes the motion of a body/shape for TOI computation. Shapes are defined with respect to the body origin,
/// which may not coincide with the center of mass. However, to support dynamics we must interpolate the center of mass
/// position.
Sweep :: struct {
	localCenter: Vec2, ///< Local center of mass position
	c1:          Vec2, ///< Starting center of mass world position
	c2:          Vec2, ///< Ending center of mass world position
	q1:          Rot,  ///< Starting world rotation
	q2:          Rot,  ///< Ending world rotation
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Evaluate the transform sweep at a specific time.
	@(link_name="b2GetSweepTransform")
	get_sweep_transform :: proc(sweep: ^Sweep, time: f32) -> Transform ---
}

/// Input parameters for b2TimeOfImpact
Toiinput :: struct {
	proxyA:      Shape_Proxy, ///< The proxy for shape A
	proxyB:      Shape_Proxy, ///< The proxy for shape B
	sweepA:      Sweep,       ///< The movement of shape A
	sweepB:      Sweep,       ///< The movement of shape B
	maxFraction: f32,         ///< Defines the sweep interval [0, maxFraction]
}

/// Describes the TOI output
Toistate :: enum u32 {
	Unknown    = 0,
	Failed     = 1,
	Overlapped = 2,
	Hit        = 3,
	Separated  = 4,
}

/// Output parameters for b2TimeOfImpact.
Toioutput :: struct {
	state:    Toistate, ///< The type of result
	fraction: f32,      ///< The sweep time of the collision
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Compute the upper bound on time before two shapes penetrate. Time is represented as
	/// a fraction between [0,tMax]. This uses a swept separating axis and may miss some intermediate,
	/// non-tunneling collisions. If you change the time interval, you should call this function
	/// again.
	@(link_name="b2TimeOfImpact")
	time_of_impact :: proc(input: ^Toiinput) -> Toioutput ---
}

/// A manifold point is a contact point belonging to a contact manifold.
/// It holds details related to the geometry and dynamics of the contact points.
/// Box2D uses speculative collision so some contact points may be separated.
/// You may use the maxNormalImpulse to determine if there was an interaction during
/// the time step.
Manifold_Point :: struct {
	/// Location of the contact point in world space. Subject to precision loss at large coordinates.
	/// @note Should only be used for debugging.
	point: Vec2,

	/// Location of the contact point relative to shapeA's origin in world space
	/// @note When used internally to the Box2D solver, this is relative to the body center of mass.
	anchorA: Vec2,

	/// Location of the contact point relative to shapeB's origin in world space
	/// @note When used internally to the Box2D solver, this is relative to the body center of mass.
	anchorB: Vec2,

	/// The separation of the contact point, negative if penetrating
	separation: f32,

	/// The impulse along the manifold normal vector.
	normalImpulse: f32,

	/// The friction impulse
	tangentImpulse: f32,

	/// The maximum normal impulse applied during sub-stepping. This is important
	/// to identify speculative contact points that had an interaction in the time step.
	maxNormalImpulse: f32,

	/// Relative normal velocity pre-solve. Used for hit events. If the normal impulse is
	/// zero then there was no hit. Negative means shapes are approaching.
	normalVelocity: f32,

	/// Uniquely identifies a contact point between two shapes
	id: u16,

	/// Did this contact point exist the previous step?
	persisted: bool,
}

/// A contact manifold describes the contact points between colliding shapes.
/// @note Box2D uses speculative collision so some contact points may be separated.
Manifold :: struct {
	/// The unit normal vector in world space, points from shape A to bodyB
	normal: Vec2,

	/// Angular impulse applied for rolling resistance. N * m * s = kg * m^2 / s
	rollingImpulse: f32,

	/// The manifold points, up to two are possible in 2D
	points: [2]Manifold_Point,

	/// The number of contacts points, will be 0, 1, or 2
	pointCount: i32,
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Compute the contact manifold between two circles
	@(link_name="b2CollideCircles")
	collide_circles :: proc(circleA: ^Circle, xfA: Transform, circleB: ^Circle, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between a capsule and circle
	@(link_name="b2CollideCapsuleAndCircle")
	collide_capsule_and_circle :: proc(capsuleA: ^Capsule, xfA: Transform, circleB: ^Circle, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between an segment and a circle
	@(link_name="b2CollideSegmentAndCircle")
	collide_segment_and_circle :: proc(segmentA: ^Segment, xfA: Transform, circleB: ^Circle, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between a polygon and a circle
	@(link_name="b2CollidePolygonAndCircle")
	collide_polygon_and_circle :: proc(polygonA: ^Polygon, xfA: Transform, circleB: ^Circle, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between a capsule and circle
	@(link_name="b2CollideCapsules")
	collide_capsules :: proc(capsuleA: ^Capsule, xfA: Transform, capsuleB: ^Capsule, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between an segment and a capsule
	@(link_name="b2CollideSegmentAndCapsule")
	collide_segment_and_capsule :: proc(segmentA: ^Segment, xfA: Transform, capsuleB: ^Capsule, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between a polygon and capsule
	@(link_name="b2CollidePolygonAndCapsule")
	collide_polygon_and_capsule :: proc(polygonA: ^Polygon, xfA: Transform, capsuleB: ^Capsule, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between two polygons
	@(link_name="b2CollidePolygons")
	collide_polygons :: proc(polygonA: ^Polygon, xfA: Transform, polygonB: ^Polygon, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between an segment and a polygon
	@(link_name="b2CollideSegmentAndPolygon")
	collide_segment_and_polygon :: proc(segmentA: ^Segment, xfA: Transform, polygonB: ^Polygon, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between a chain segment and a circle
	@(link_name="b2CollideChainSegmentAndCircle")
	collide_chain_segment_and_circle :: proc(segmentA: ^Chain_Segment, xfA: Transform, circleB: ^Circle, xfB: Transform) -> Manifold ---

	/// Compute the contact manifold between a chain segment and a capsule
	@(link_name="b2CollideChainSegmentAndCapsule")
	collide_chain_segment_and_capsule :: proc(segmentA: ^Chain_Segment, xfA: Transform, capsuleB: ^Capsule, xfB: Transform, cache: ^Simplex_Cache) -> Manifold ---

	/// Compute the contact manifold between a chain segment and a rounded polygon
	@(link_name="b2CollideChainSegmentAndPolygon")
	collide_chain_segment_and_polygon :: proc(segmentA: ^Chain_Segment, xfA: Transform, polygonB: ^Polygon, xfB: Transform, cache: ^Simplex_Cache) -> Manifold ---
}

/// The dynamic tree structure. This should be considered private data.
/// It is placed here for performance reasons.
Dynamic_Tree :: struct {
	/// The tree nodes
	nodes: [^]Tree_Node,

	/// The root index
	root: i32,

	/// The number of nodes
	nodeCount: i32,

	/// The allocated node space
	nodeCapacity: i32,

	/// Node free list
	freeList: i32,

	/// Number of proxies created
	proxyCount: i32,

	/// Leaf indices for rebuild
	leafIndices: ^i32,

	/// Leaf bounding boxes for rebuild
	leafBoxes: ^Aabb,

	/// Leaf bounding box centers for rebuild
	leafCenters: ^Vec2,

	/// Bins for sorting during rebuild
	binIndices: ^i32,

	/// Allocated space for rebuilding
	rebuildCapacity: i32,
}

Tree_Node :: struct {}

/// These are performance results returned by dynamic tree queries.
Tree_Stats :: struct {
	/// Number of internal nodes visited during the query
	nodeVisits: i32,

	/// Number of leaf nodes visited during the query
	leafVisits: i32,
}

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Constructing the tree initializes the node pool.
	@(link_name="b2DynamicTree_Create")
	dynamic_tree_create :: proc() -> Dynamic_Tree ---

	/// Destroy the tree, freeing the node pool.
	@(link_name="b2DynamicTree_Destroy")
	dynamic_tree_destroy :: proc(tree: ^Dynamic_Tree) ---

	/// Create a proxy. Provide an AABB and a userData value.
	@(link_name="b2DynamicTree_CreateProxy")
	dynamic_tree_create_proxy :: proc(tree: ^Dynamic_Tree, aabb: Aabb, categoryBits: u64, userData: i32) -> i32 ---

	/// Destroy a proxy. This asserts if the id is invalid.
	@(link_name="b2DynamicTree_DestroyProxy")
	dynamic_tree_destroy_proxy :: proc(tree: ^Dynamic_Tree, proxyId: i32) ---

	/// Move a proxy to a new AABB by removing and reinserting into the tree.
	@(link_name="b2DynamicTree_MoveProxy")
	dynamic_tree_move_proxy :: proc(tree: ^Dynamic_Tree, proxyId: i32, aabb: Aabb) ---

	/// Enlarge a proxy and enlarge ancestors as necessary.
	@(link_name="b2DynamicTree_EnlargeProxy")
	dynamic_tree_enlarge_proxy :: proc(tree: ^Dynamic_Tree, proxyId: i32, aabb: Aabb) ---
}

/// This function receives proxies found in the AABB query.
/// @return true if the query should continue
Tree_Query_Callback_Fcn :: proc "c" (proxyId: i32, userData: i32, _context: rawptr) -> bool

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Query an AABB for overlapping proxies. The callback class is called for each proxy that overlaps the supplied AABB.
	///	@return performance data
	@(link_name="b2DynamicTree_Query")
	dynamic_tree_query :: proc(tree: ^Dynamic_Tree, aabb: Aabb, maskBits: u64, callback: Tree_Query_Callback_Fcn, _context: rawptr) -> Tree_Stats ---
}

/// This function receives clipped ray cast input for a proxy. The function
/// returns the new ray fraction.
/// - return a value of 0 to terminate the ray cast
/// - return a value less than input->maxFraction to clip the ray
/// - return a value of input->maxFraction to continue the ray cast without clipping
Tree_Ray_Cast_Callback_Fcn :: proc "c" (input: ^Ray_Cast_Input, proxyId: i32, userData: i32, _context: rawptr) -> f32

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Ray cast against the proxies in the tree. This relies on the callback
	/// to perform a exact ray cast in the case were the proxy contains a shape.
	/// The callback also performs the any collision filtering. This has performance
	/// roughly equal to k * log(n), where k is the number of collisions and n is the
	/// number of proxies in the tree.
	/// Bit-wise filtering using mask bits can greatly improve performance in some scenarios.
	///	However, this filtering may be approximate, so the user should still apply filtering to results.
	/// @param tree the dynamic tree to ray cast
	/// @param input the ray cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1)
	/// @param maskBits mask bit hint: `bool accept = (maskBits & node->categoryBits) != 0;`
	/// @param callback a callback class that is called for each proxy that is hit by the ray
	/// @param context user context that is passed to the callback
	///	@return performance data
	@(link_name="b2DynamicTree_RayCast")
	dynamic_tree_ray_cast :: proc(tree: ^Dynamic_Tree, input: ^Ray_Cast_Input, maskBits: u64, callback: Tree_Ray_Cast_Callback_Fcn, _context: rawptr) -> Tree_Stats ---
}

/// This function receives clipped ray cast input for a proxy. The function
/// returns the new ray fraction.
/// - return a value of 0 to terminate the ray cast
/// - return a value less than input->maxFraction to clip the ray
/// - return a value of input->maxFraction to continue the ray cast without clipping
Tree_Shape_Cast_Callback_Fcn :: proc "c" (input: ^Shape_Cast_Input, proxyId: i32, userData: i32, _context: rawptr) -> f32

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Ray cast against the proxies in the tree. This relies on the callback
	/// to perform a exact ray cast in the case were the proxy contains a shape.
	/// The callback also performs the any collision filtering. This has performance
	/// roughly equal to k * log(n), where k is the number of collisions and n is the
	/// number of proxies in the tree.
	/// @param tree the dynamic tree to ray cast
	/// @param input the ray cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).
	/// @param maskBits filter bits: `bool accept = (maskBits & node->categoryBits) != 0;`
	/// @param callback a callback class that is called for each proxy that is hit by the shape
	/// @param context user context that is passed to the callback
	///	@return performance data
	@(link_name="b2DynamicTree_ShapeCast")
	dynamic_tree_shape_cast :: proc(tree: ^Dynamic_Tree, input: ^Shape_Cast_Input, maskBits: u64, callback: Tree_Shape_Cast_Callback_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Get the height of the binary tree.
	@(link_name="b2DynamicTree_GetHeight")
	dynamic_tree_get_height :: proc(tree: ^Dynamic_Tree) -> i32 ---

	/// Get the ratio of the sum of the node areas to the root area.
	@(link_name="b2DynamicTree_GetAreaRatio")
	dynamic_tree_get_area_ratio :: proc(tree: ^Dynamic_Tree) -> f32 ---

	/// Get the number of proxies created
	@(link_name="b2DynamicTree_GetProxyCount")
	dynamic_tree_get_proxy_count :: proc(tree: ^Dynamic_Tree) -> i32 ---

	/// Rebuild the tree while retaining subtrees that haven't changed. Returns the number of boxes sorted.
	@(link_name="b2DynamicTree_Rebuild")
	dynamic_tree_rebuild :: proc(tree: ^Dynamic_Tree, fullBuild: bool) -> i32 ---

	/// Get the number of bytes used by this tree
	@(link_name="b2DynamicTree_GetByteCount")
	dynamic_tree_get_byte_count :: proc(tree: ^Dynamic_Tree) -> i32 ---

	/// Get proxy user data
	@(link_name="b2DynamicTree_GetUserData")
	dynamic_tree_get_user_data :: proc(tree: ^Dynamic_Tree, proxyId: i32) -> i32 ---

	/// Get the AABB of a proxy
	@(link_name="b2DynamicTree_GetAABB")
	dynamic_tree_get_aabb :: proc(tree: ^Dynamic_Tree, proxyId: i32) -> Aabb ---

	/// Validate this tree. For testing.
	@(link_name="b2DynamicTree_Validate")
	dynamic_tree_validate :: proc(tree: ^Dynamic_Tree) ---

	/// Validate this tree has no enlarged AABBs. For testing.
	@(link_name="b2DynamicTree_ValidateNoEnlarged")
	dynamic_tree_validate_no_enlarged :: proc(tree: ^Dynamic_Tree) ---
}

