// SPDX-FileCopyrightText: 2023 Erin Catto
// SPDX-License-Identifier: MIT
package box2d

foreign import lib "box2d.lib"
_ :: lib

@(default_calling_convention="c", link_prefix="b2")
foreign lib {
	/// Create a world for rigid body simulation. A world contains bodies, shapes, and constraints. You make create
	/// up to 128 worlds. Each world is completely independent and may be simulated in parallel.
	/// @return the world id.
	@(link_name="b2CreateWorld")
	create_world :: proc(#by_ptr def: World_Def) -> World_Id ---

	/// Destroy a world
	@(link_name="b2DestroyWorld")
	destroy_world :: proc(worldId: World_Id) ---

	/// World id validation. Provides validation for up to 64K allocations.
	@(link_name="b2World_IsValid")
	world_is_valid :: proc(id: World_Id) -> bool ---

	/// Simulate a world for one time step. This performs collision detection, integration, and constraint solution.
	/// @param worldId The world to simulate
	/// @param timeStep The amount of time to simulate, this should be a fixed number. Usually 1/60.
	/// @param subStepCount The number of sub-steps, increasing the sub-step count can increase accuracy. Usually 4.
	@(link_name="b2World_Step")
	world_step :: proc(worldId: World_Id, timeStep: f32, subStepCount: i32) ---

	/// Call this to draw shapes and other debug draw data
	@(link_name="b2World_Draw")
	world_draw :: proc(worldId: World_Id, draw: ^Debug_Draw) ---

	/// Get the body events for the current time step. The event data is transient. Do not store a reference to this data.
	@(link_name="b2World_GetBodyEvents")
	world_get_body_events :: proc(worldId: World_Id) -> Body_Events ---

	/// Get sensor events for the current time step. The event data is transient. Do not store a reference to this data.
	@(link_name="b2World_GetSensorEvents")
	world_get_sensor_events :: proc(worldId: World_Id) -> Sensor_Events ---

	/// Get contact events for this current time step. The event data is transient. Do not store a reference to this data.
	@(link_name="b2World_GetContactEvents")
	world_get_contact_events :: proc(worldId: World_Id) -> Contact_Events ---

	/// Overlap test for all shapes that *potentially* overlap the provided AABB
	@(link_name="b2World_OverlapAABB")
	world_overlap_aabb :: proc(worldId: World_Id, aabb: Aabb, filter: Query_Filter, fcn: Overlap_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Overlap test for for all shapes that overlap the provided point.
	@(link_name="b2World_OverlapPoint")
	world_overlap_point :: proc(worldId: World_Id, point: Vec2, transform: Transform, filter: Query_Filter, fcn: Overlap_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Overlap test for for all shapes that overlap the provided circle. A zero radius may be used for a point query.
	@(link_name="b2World_OverlapCircle")
	world_overlap_circle :: proc(worldId: World_Id, circle: ^Circle, transform: Transform, filter: Query_Filter, fcn: Overlap_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Overlap test for all shapes that overlap the provided capsule
	@(link_name="b2World_OverlapCapsule")
	world_overlap_capsule :: proc(worldId: World_Id, capsule: ^Capsule, transform: Transform, filter: Query_Filter, fcn: Overlap_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Overlap test for all shapes that overlap the provided polygon
	@(link_name="b2World_OverlapPolygon")
	world_overlap_polygon :: proc(worldId: World_Id, polygon: ^Polygon, transform: Transform, filter: Query_Filter, fcn: Overlap_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Cast a ray into the world to collect shapes in the path of the ray.
	/// Your callback function controls whether you get the closest point, any point, or n-points.
	/// The ray-cast ignores shapes that contain the starting point.
	/// @note The callback function may receive shapes in any order
	/// @param worldId The world to cast the ray against
	/// @param origin The start point of the ray
	/// @param translation The translation of the ray from the start point to the end point
	/// @param filter Contains bit flags to filter unwanted shapes from the results
	/// @param fcn A user implemented callback function
	/// @param context A user context that is passed along to the callback function
	///	@return traversal performance counters
	@(link_name="b2World_CastRay")
	world_cast_ray :: proc(worldId: World_Id, origin: Vec2, translation: Vec2, filter: Query_Filter, fcn: Cast_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Cast a ray into the world to collect the closest hit. This is a convenience function.
	/// This is less general than b2World_CastRay() and does not allow for custom filtering.
	@(link_name="b2World_CastRayClosest")
	world_cast_ray_closest :: proc(worldId: World_Id, origin: Vec2, translation: Vec2, filter: Query_Filter) -> Ray_Result ---

	/// Cast a circle through the world. Similar to a cast ray except that a circle is cast instead of a point.
	///	@see b2World_CastRay
	@(link_name="b2World_CastCircle")
	world_cast_circle :: proc(worldId: World_Id, circle: ^Circle, originTransform: Transform, translation: Vec2, filter: Query_Filter, fcn: Cast_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Cast a capsule through the world. Similar to a cast ray except that a capsule is cast instead of a point.
	///	@see b2World_CastRay
	@(link_name="b2World_CastCapsule")
	world_cast_capsule :: proc(worldId: World_Id, capsule: ^Capsule, originTransform: Transform, translation: Vec2, filter: Query_Filter, fcn: Cast_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Cast a polygon through the world. Similar to a cast ray except that a polygon is cast instead of a point.
	///	@see b2World_CastRay
	@(link_name="b2World_CastPolygon")
	world_cast_polygon :: proc(worldId: World_Id, polygon: ^Polygon, originTransform: Transform, translation: Vec2, filter: Query_Filter, fcn: Cast_Result_Fcn, _context: rawptr) -> Tree_Stats ---

	/// Enable/disable sleep. If your application does not need sleeping, you can gain some performance
	/// by disabling sleep completely at the world level.
	/// @see b2WorldDef
	@(link_name="b2World_EnableSleeping")
	world_enable_sleeping :: proc(worldId: World_Id, flag: bool) ---

	/// Is body sleeping enabled?
	@(link_name="b2World_IsSleepingEnabled")
	world_is_sleeping_enabled :: proc(worldId: World_Id) -> bool ---

	/// Enable/disable continuous collision between dynamic and static bodies. Generally you should keep continuous
	/// collision enabled to prevent fast moving objects from going through static objects. The performance gain from
	/// disabling continuous collision is minor.
	/// @see b2WorldDef
	@(link_name="b2World_EnableContinuous")
	world_enable_continuous :: proc(worldId: World_Id, flag: bool) ---

	/// Is continuous collision enabled?
	@(link_name="b2World_IsContinuousEnabled")
	world_is_continuous_enabled :: proc(worldId: World_Id) -> bool ---

	/// Adjust the restitution threshold. It is recommended not to make this value very small
	/// because it will prevent bodies from sleeping. Usually in meters per second.
	/// @see b2WorldDef
	@(link_name="b2World_SetRestitutionThreshold")
	world_set_restitution_threshold :: proc(worldId: World_Id, value: f32) ---

	/// Get the the restitution speed threshold. Usually in meters per second.
	@(link_name="b2World_GetRestitutionThreshold")
	world_get_restitution_threshold :: proc(worldId: World_Id) -> f32 ---

	/// Adjust the hit event threshold. This controls the collision speed needed to generate a b2ContactHitEvent.
	/// Usually in meters per second.
	/// @see b2WorldDef::hitEventThreshold
	@(link_name="b2World_SetHitEventThreshold")
	world_set_hit_event_threshold :: proc(worldId: World_Id, value: f32) ---

	/// Get the the hit event speed threshold. Usually in meters per second.
	@(link_name="b2World_GetHitEventThreshold")
	world_get_hit_event_threshold :: proc(worldId: World_Id) -> f32 ---

	/// Register the custom filter callback. This is optional.
	@(link_name="b2World_SetCustomFilterCallback")
	world_set_custom_filter_callback :: proc(worldId: World_Id, fcn: Custom_Filter_Fcn, _context: rawptr) ---

	/// Register the pre-solve callback. This is optional.
	@(link_name="b2World_SetPreSolveCallback")
	world_set_pre_solve_callback :: proc(worldId: World_Id, fcn: Pre_Solve_Fcn, _context: rawptr) ---

	/// Set the gravity vector for the entire world. Box2D has no concept of an up direction and this
	/// is left as a decision for the application. Usually in m/s^2.
	/// @see b2WorldDef
	@(link_name="b2World_SetGravity")
	world_set_gravity :: proc(worldId: World_Id, gravity: Vec2) ---

	/// Get the gravity vector
	@(link_name="b2World_GetGravity")
	world_get_gravity :: proc(worldId: World_Id) -> Vec2 ---

	/// Apply a radial explosion
	/// @param worldId The world id
	/// @param explosionDef The explosion definition
	@(link_name="b2World_Explode")
	world_explode :: proc(worldId: World_Id, explosionDef: ^Explosion_Def) ---

	/// Adjust contact tuning parameters
	/// @param worldId The world id
	/// @param hertz The contact stiffness (cycles per second)
	/// @param dampingRatio The contact bounciness with 1 being critical damping (non-dimensional)
	/// @param pushSpeed The maximum contact constraint push out speed (meters per second)
	/// @note Advanced feature
	@(link_name="b2World_SetContactTuning")
	world_set_contact_tuning :: proc(worldId: World_Id, hertz: f32, dampingRatio: f32, pushSpeed: f32) ---

	/// Adjust joint tuning parameters
	/// @param worldId The world id
	/// @param hertz The contact stiffness (cycles per second)
	/// @param dampingRatio The contact bounciness with 1 being critical damping (non-dimensional)
	/// @note Advanced feature
	@(link_name="b2World_SetJointTuning")
	world_set_joint_tuning :: proc(worldId: World_Id, hertz: f32, dampingRatio: f32) ---

	/// Set the maximum linear speed. Usually in m/s.
	@(link_name="b2World_SetMaximumLinearSpeed")
	world_set_maximum_linear_speed :: proc(worldId: World_Id, maximumLinearSpeed: f32) ---

	/// Get the maximum linear speed. Usually in m/s.
	@(link_name="b2World_GetMaximumLinearSpeed")
	world_get_maximum_linear_speed :: proc(worldId: World_Id) -> f32 ---

	/// Enable/disable constraint warm starting. Advanced feature for testing. Disabling
	/// sleeping greatly reduces stability and provides no performance gain.
	@(link_name="b2World_EnableWarmStarting")
	world_enable_warm_starting :: proc(worldId: World_Id, flag: bool) ---

	/// Is constraint warm starting enabled?
	@(link_name="b2World_IsWarmStartingEnabled")
	world_is_warm_starting_enabled :: proc(worldId: World_Id) -> bool ---

	/// Get the number of awake bodies.
	@(link_name="b2World_GetAwakeBodyCount")
	world_get_awake_body_count :: proc(worldId: World_Id) -> i32 ---

	/// Get the current world performance profile
	@(link_name="b2World_GetProfile")
	world_get_profile :: proc(worldId: World_Id) -> Profile ---

	/// Get world counters and sizes
	@(link_name="b2World_GetCounters")
	world_get_counters :: proc(worldId: World_Id) -> Counters ---

	/// Set the user data pointer.
	@(link_name="b2World_SetUserData")
	world_set_user_data :: proc(worldId: World_Id, userData: rawptr) ---

	/// Get the user data pointer.
	@(link_name="b2World_GetUserData")
	world_get_user_data :: proc(worldId: World_Id) -> rawptr ---

	/// Set the friction callback. Passing NULL resets to default.
	@(link_name="b2World_SetFrictionCallback")
	world_set_friction_callback :: proc(worldId: World_Id, callback: Friction_Callback) ---

	/// Set the restitution callback. Passing NULL resets to default.
	@(link_name="b2World_SetRestitutionCallback")
	world_set_restitution_callback :: proc(worldId: World_Id, callback: Restitution_Callback) ---

	/// Dump memory stats to box2d_memory.txt
	@(link_name="b2World_DumpMemoryStats")
	world_dump_memory_stats :: proc(worldId: World_Id) ---

	/// This is for internal testing
	@(link_name="b2World_RebuildStaticTree")
	world_rebuild_static_tree :: proc(worldId: World_Id) ---

	/// This is for internal testing
	@(link_name="b2World_EnableSpeculative")
	world_enable_speculative :: proc(worldId: World_Id, flag: bool) ---

	/// Create a rigid body given a definition. No reference to the definition is retained. So you can create the definition
	/// on the stack and pass it as a pointer.
	/// @code{.c}
	/// b2BodyDef bodyDef = b2DefaultBodyDef();
	/// b2BodyId myBodyId = b2CreateBody(myWorldId, &bodyDef);
	/// @endcode
	/// @warning This function is locked during callbacks.
	@(link_name="b2CreateBody")
	create_body :: proc(worldId: World_Id, #by_ptr def: Body_Def) -> Body_Id ---

	/// Destroy a rigid body given an id. This destroys all shapes and joints attached to the body.
	/// Do not keep references to the associated shapes and joints.
	@(link_name="b2DestroyBody")
	destroy_body :: proc(bodyId: Body_Id) ---

	/// Body identifier validation. Can be used to detect orphaned ids. Provides validation for up to 64K allocations.
	@(link_name="b2Body_IsValid")
	body_is_valid :: proc(id: Body_Id) -> bool ---

	/// Get the body type: static, kinematic, or dynamic
	@(link_name="b2Body_GetType")
	body_get_type :: proc(bodyId: Body_Id) -> Body_Type ---

	/// Change the body type. This is an expensive operation. This automatically updates the mass
	/// properties regardless of the automatic mass setting.
	@(link_name="b2Body_SetType")
	body_set_type :: proc(bodyId: Body_Id, type: Body_Type) ---

	/// Set the body name. Up to 31 characters excluding 0 termination.
	@(link_name="b2Body_SetName")
	body_set_name :: proc(bodyId: Body_Id, name: cstring) ---

	/// Get the body name. May be null.
	@(link_name="b2Body_GetName")
	body_get_name :: proc(bodyId: Body_Id) -> cstring ---

	/// Set the user data for a body
	@(link_name="b2Body_SetUserData")
	body_set_user_data :: proc(bodyId: Body_Id, userData: rawptr) ---

	/// Get the user data stored in a body
	@(link_name="b2Body_GetUserData")
	body_get_user_data :: proc(bodyId: Body_Id) -> rawptr ---

	/// Get the world position of a body. This is the location of the body origin.
	@(link_name="b2Body_GetPosition")
	body_get_position :: proc(bodyId: Body_Id) -> Vec2 ---

	/// Get the world rotation of a body as a cosine/sine pair (complex number)
	@(link_name="b2Body_GetRotation")
	body_get_rotation :: proc(bodyId: Body_Id) -> Rot ---

	/// Get the world transform of a body.
	@(link_name="b2Body_GetTransform")
	body_get_transform :: proc(bodyId: Body_Id) -> Transform ---

	/// Set the world transform of a body. This acts as a teleport and is fairly expensive.
	/// @note Generally you should create a body with then intended transform.
	/// @see b2BodyDef::position and b2BodyDef::angle
	@(link_name="b2Body_SetTransform")
	body_set_transform :: proc(bodyId: Body_Id, position: Vec2, rotation: Rot) ---

	/// Get a local point on a body given a world point
	@(link_name="b2Body_GetLocalPoint")
	body_get_local_point :: proc(bodyId: Body_Id, worldPoint: Vec2) -> Vec2 ---

	/// Get a world point on a body given a local point
	@(link_name="b2Body_GetWorldPoint")
	body_get_world_point :: proc(bodyId: Body_Id, localPoint: Vec2) -> Vec2 ---

	/// Get a local vector on a body given a world vector
	@(link_name="b2Body_GetLocalVector")
	body_get_local_vector :: proc(bodyId: Body_Id, worldVector: Vec2) -> Vec2 ---

	/// Get a world vector on a body given a local vector
	@(link_name="b2Body_GetWorldVector")
	body_get_world_vector :: proc(bodyId: Body_Id, localVector: Vec2) -> Vec2 ---

	/// Get the linear velocity of a body's center of mass. Usually in meters per second.
	@(link_name="b2Body_GetLinearVelocity")
	body_get_linear_velocity :: proc(bodyId: Body_Id) -> Vec2 ---

	/// Get the angular velocity of a body in radians per second
	@(link_name="b2Body_GetAngularVelocity")
	body_get_angular_velocity :: proc(bodyId: Body_Id) -> f32 ---

	/// Set the linear velocity of a body. Usually in meters per second.
	@(link_name="b2Body_SetLinearVelocity")
	body_set_linear_velocity :: proc(bodyId: Body_Id, linearVelocity: Vec2) ---

	/// Set the angular velocity of a body in radians per second
	@(link_name="b2Body_SetAngularVelocity")
	body_set_angular_velocity :: proc(bodyId: Body_Id, angularVelocity: f32) ---

	/// Get the linear velocity of a local point attached to a body. Usually in meters per second.
	@(link_name="b2Body_GetLocalPointVelocity")
	body_get_local_point_velocity :: proc(bodyId: Body_Id, localPoint: Vec2) -> Vec2 ---

	/// Get the linear velocity of a world point attached to a body. Usually in meters per second.
	@(link_name="b2Body_GetWorldPointVelocity")
	body_get_world_point_velocity :: proc(bodyId: Body_Id, worldPoint: Vec2) -> Vec2 ---

	/// Apply a force at a world point. If the force is not applied at the center of mass,
	/// it will generate a torque and affect the angular velocity. This optionally wakes up the body.
	/// The force is ignored if the body is not awake.
	/// @param bodyId The body id
	/// @param force The world force vector, usually in newtons (N)
	/// @param point The world position of the point of application
	/// @param wake Option to wake up the body
	@(link_name="b2Body_ApplyForce")
	body_apply_force :: proc(bodyId: Body_Id, force: Vec2, point: Vec2, wake: bool) ---

	/// Apply a force to the center of mass. This optionally wakes up the body.
	/// The force is ignored if the body is not awake.
	/// @param bodyId The body id
	/// @param force the world force vector, usually in newtons (N).
	/// @param wake also wake up the body
	@(link_name="b2Body_ApplyForceToCenter")
	body_apply_force_to_center :: proc(bodyId: Body_Id, force: Vec2, wake: bool) ---

	/// Apply a torque. This affects the angular velocity without affecting the linear velocity.
	/// This optionally wakes the body. The torque is ignored if the body is not awake.
	/// @param bodyId The body id
	/// @param torque about the z-axis (out of the screen), usually in N*m.
	/// @param wake also wake up the body
	@(link_name="b2Body_ApplyTorque")
	body_apply_torque :: proc(bodyId: Body_Id, torque: f32, wake: bool) ---

	/// Apply an impulse at a point. This immediately modifies the velocity.
	/// It also modifies the angular velocity if the point of application
	/// is not at the center of mass. This optionally wakes the body.
	/// The impulse is ignored if the body is not awake.
	/// @param bodyId The body id
	/// @param impulse the world impulse vector, usually in N*s or kg*m/s.
	/// @param point the world position of the point of application.
	/// @param wake also wake up the body
	/// @warning This should be used for one-shot impulses. If you need a steady force,
	/// use a force instead, which will work better with the sub-stepping solver.
	@(link_name="b2Body_ApplyLinearImpulse")
	body_apply_linear_impulse :: proc(bodyId: Body_Id, impulse: Vec2, point: Vec2, wake: bool) ---

	/// Apply an impulse to the center of mass. This immediately modifies the velocity.
	/// The impulse is ignored if the body is not awake. This optionally wakes the body.
	/// @param bodyId The body id
	/// @param impulse the world impulse vector, usually in N*s or kg*m/s.
	/// @param wake also wake up the body
	/// @warning This should be used for one-shot impulses. If you need a steady force,
	/// use a force instead, which will work better with the sub-stepping solver.
	@(link_name="b2Body_ApplyLinearImpulseToCenter")
	body_apply_linear_impulse_to_center :: proc(bodyId: Body_Id, impulse: Vec2, wake: bool) ---

	/// Apply an angular impulse. The impulse is ignored if the body is not awake.
	/// This optionally wakes the body.
	/// @param bodyId The body id
	/// @param impulse the angular impulse, usually in units of kg*m*m/s
	/// @param wake also wake up the body
	/// @warning This should be used for one-shot impulses. If you need a steady force,
	/// use a force instead, which will work better with the sub-stepping solver.
	@(link_name="b2Body_ApplyAngularImpulse")
	body_apply_angular_impulse :: proc(bodyId: Body_Id, impulse: f32, wake: bool) ---

	/// Get the mass of the body, usually in kilograms
	@(link_name="b2Body_GetMass")
	body_get_mass :: proc(bodyId: Body_Id) -> f32 ---

	/// Get the rotational inertia of the body, usually in kg*m^2
	@(link_name="b2Body_GetRotationalInertia")
	body_get_rotational_inertia :: proc(bodyId: Body_Id) -> f32 ---

	/// Get the center of mass position of the body in local space
	@(link_name="b2Body_GetLocalCenterOfMass")
	body_get_local_center_of_mass :: proc(bodyId: Body_Id) -> Vec2 ---

	/// Get the center of mass position of the body in world space
	@(link_name="b2Body_GetWorldCenterOfMass")
	body_get_world_center_of_mass :: proc(bodyId: Body_Id) -> Vec2 ---

	/// Override the body's mass properties. Normally this is computed automatically using the
	/// shape geometry and density. This information is lost if a shape is added or removed or if the
	/// body type changes.
	@(link_name="b2Body_SetMassData")
	body_set_mass_data :: proc(bodyId: Body_Id, massData: Mass_Data) ---

	/// Get the mass data for a body
	@(link_name="b2Body_GetMassData")
	body_get_mass_data :: proc(bodyId: Body_Id) -> Mass_Data ---

	/// This update the mass properties to the sum of the mass properties of the shapes.
	/// This normally does not need to be called unless you called SetMassData to override
	/// the mass and you later want to reset the mass.
	/// You may also use this when automatic mass computation has been disabled.
	/// You should call this regardless of body type.
	@(link_name="b2Body_ApplyMassFromShapes")
	body_apply_mass_from_shapes :: proc(bodyId: Body_Id) ---

	/// Adjust the linear damping. Normally this is set in b2BodyDef before creation.
	@(link_name="b2Body_SetLinearDamping")
	body_set_linear_damping :: proc(bodyId: Body_Id, linearDamping: f32) ---

	/// Get the current linear damping.
	@(link_name="b2Body_GetLinearDamping")
	body_get_linear_damping :: proc(bodyId: Body_Id) -> f32 ---

	/// Adjust the angular damping. Normally this is set in b2BodyDef before creation.
	@(link_name="b2Body_SetAngularDamping")
	body_set_angular_damping :: proc(bodyId: Body_Id, angularDamping: f32) ---

	/// Get the current angular damping.
	@(link_name="b2Body_GetAngularDamping")
	body_get_angular_damping :: proc(bodyId: Body_Id) -> f32 ---

	/// Adjust the gravity scale. Normally this is set in b2BodyDef before creation.
	/// @see b2BodyDef::gravityScale
	@(link_name="b2Body_SetGravityScale")
	body_set_gravity_scale :: proc(bodyId: Body_Id, gravityScale: f32) ---

	/// Get the current gravity scale
	@(link_name="b2Body_GetGravityScale")
	body_get_gravity_scale :: proc(bodyId: Body_Id) -> f32 ---

	/// @return true if this body is awake
	@(link_name="b2Body_IsAwake")
	body_is_awake :: proc(bodyId: Body_Id) -> bool ---

	/// Wake a body from sleep. This wakes the entire island the body is touching.
	/// @warning Putting a body to sleep will put the entire island of bodies touching this body to sleep,
	/// which can be expensive and possibly unintuitive.
	@(link_name="b2Body_SetAwake")
	body_set_awake :: proc(bodyId: Body_Id, awake: bool) ---

	/// Enable or disable sleeping for this body. If sleeping is disabled the body will wake.
	@(link_name="b2Body_EnableSleep")
	body_enable_sleep :: proc(bodyId: Body_Id, enableSleep: bool) ---

	/// Returns true if sleeping is enabled for this body
	@(link_name="b2Body_IsSleepEnabled")
	body_is_sleep_enabled :: proc(bodyId: Body_Id) -> bool ---

	/// Set the sleep threshold, usually in meters per second
	@(link_name="b2Body_SetSleepThreshold")
	body_set_sleep_threshold :: proc(bodyId: Body_Id, sleepThreshold: f32) ---

	/// Get the sleep threshold, usually in meters per second.
	@(link_name="b2Body_GetSleepThreshold")
	body_get_sleep_threshold :: proc(bodyId: Body_Id) -> f32 ---

	/// Returns true if this body is enabled
	@(link_name="b2Body_IsEnabled")
	body_is_enabled :: proc(bodyId: Body_Id) -> bool ---

	/// Disable a body by removing it completely from the simulation. This is expensive.
	@(link_name="b2Body_Disable")
	body_disable :: proc(bodyId: Body_Id) ---

	/// Enable a body by adding it to the simulation. This is expensive.
	@(link_name="b2Body_Enable")
	body_enable :: proc(bodyId: Body_Id) ---

	/// Set this body to have fixed rotation. This causes the mass to be reset in all cases.
	@(link_name="b2Body_SetFixedRotation")
	body_set_fixed_rotation :: proc(bodyId: Body_Id, flag: bool) ---

	/// Does this body have fixed rotation?
	@(link_name="b2Body_IsFixedRotation")
	body_is_fixed_rotation :: proc(bodyId: Body_Id) -> bool ---

	/// Set this body to be a bullet. A bullet does continuous collision detection
	/// against dynamic bodies (but not other bullets).
	@(link_name="b2Body_SetBullet")
	body_set_bullet :: proc(bodyId: Body_Id, flag: bool) ---

	/// Is this body a bullet?
	@(link_name="b2Body_IsBullet")
	body_is_bullet :: proc(bodyId: Body_Id) -> bool ---

	/// Enable/disable contact events on all shapes.
	/// @see b2ShapeDef::enableContactEvents
	/// @warning changing this at runtime may cause mismatched begin/end touch events
	@(link_name="b2Body_EnableContactEvents")
	body_enable_contact_events :: proc(bodyId: Body_Id, flag: bool) ---

	/// Enable/disable hit events on all shapes
	/// @see b2ShapeDef::enableHitEvents
	@(link_name="b2Body_EnableHitEvents")
	body_enable_hit_events :: proc(bodyId: Body_Id, flag: bool) ---

	/// Get the world that owns this body
	@(link_name="b2Body_GetWorld")
	body_get_world :: proc(bodyId: Body_Id) -> World_Id ---

	/// Get the number of shapes on this body
	@(link_name="b2Body_GetShapeCount")
	body_get_shape_count :: proc(bodyId: Body_Id) -> i32 ---

	/// Get the shape ids for all shapes on this body, up to the provided capacity.
	/// @returns the number of shape ids stored in the user array
	@(link_name="b2Body_GetShapes")
	body_get_shapes :: proc(bodyId: Body_Id, shapeArray: ^Shape_Id, capacity: i32) -> i32 ---

	/// Get the number of joints on this body
	@(link_name="b2Body_GetJointCount")
	body_get_joint_count :: proc(bodyId: Body_Id) -> i32 ---

	/// Get the joint ids for all joints on this body, up to the provided capacity
	/// @returns the number of joint ids stored in the user array
	@(link_name="b2Body_GetJoints")
	body_get_joints :: proc(bodyId: Body_Id, jointArray: ^Joint_Id, capacity: i32) -> i32 ---

	/// Get the maximum capacity required for retrieving all the touching contacts on a body
	@(link_name="b2Body_GetContactCapacity")
	body_get_contact_capacity :: proc(bodyId: Body_Id) -> i32 ---

	/// Get the touching contact data for a body.
	/// @note Box2D uses speculative collision so some contact points may be separated.
	/// @returns the number of elements filled in the provided array
	/// @warning do not ignore the return value, it specifies the valid number of elements
	@(link_name="b2Body_GetContactData")
	body_get_contact_data :: proc(bodyId: Body_Id, contactData: ^Contact_Data, capacity: i32) -> i32 ---

	/// Get the current world AABB that contains all the attached shapes. Note that this may not encompass the body origin.
	/// If there are no shapes attached then the returned AABB is empty and centered on the body origin.
	@(link_name="b2Body_ComputeAABB")
	body_compute_aabb :: proc(bodyId: Body_Id) -> Aabb ---

	/// Create a circle shape and attach it to a body. The shape definition and geometry are fully cloned.
	/// Contacts are not created until the next time step.
	/// @return the shape id for accessing the shape
	@(link_name="b2CreateCircleShape")
	create_circle_shape :: proc(bodyId: Body_Id, #by_ptr def: Shape_Def, #by_ptr circle: Circle) -> Shape_Id ---

	/// Create a line segment shape and attach it to a body. The shape definition and geometry are fully cloned.
	/// Contacts are not created until the next time step.
	/// @return the shape id for accessing the shape
	@(link_name="b2CreateSegmentShape")
	create_segment_shape :: proc(bodyId: Body_Id, def: ^Shape_Def, segment: ^Segment) -> Shape_Id ---

	/// Create a capsule shape and attach it to a body. The shape definition and geometry are fully cloned.
	/// Contacts are not created until the next time step.
	/// @return the shape id for accessing the shape
	@(link_name="b2CreateCapsuleShape")
	create_capsule_shape :: proc(bodyId: Body_Id, def: ^Shape_Def, capsule: ^Capsule) -> Shape_Id ---

	/// Create a polygon shape and attach it to a body. The shape definition and geometry are fully cloned.
	/// Contacts are not created until the next time step.
	/// @return the shape id for accessing the shape
	@(link_name="b2CreatePolygonShape")
	create_polygon_shape :: proc(bodyId: Body_Id, #by_ptr def: Shape_Def, #by_ptr polygon: Polygon) -> Shape_Id ---

	/// Destroy a shape. You may defer the body mass update which can improve performance if several shapes on a
	///	body are destroyed at once.
	///	@see b2Body_ApplyMassFromShapes
	@(link_name="b2DestroyShape")
	destroy_shape :: proc(shapeId: Shape_Id, updateBodyMass: bool) ---

	/// Shape identifier validation. Provides validation for up to 64K allocations.
	@(link_name="b2Shape_IsValid")
	shape_is_valid :: proc(id: Shape_Id) -> bool ---

	/// Get the type of a shape
	@(link_name="b2Shape_GetType")
	shape_get_type :: proc(shapeId: Shape_Id) -> Shape_Type ---

	/// Get the id of the body that a shape is attached to
	@(link_name="b2Shape_GetBody")
	shape_get_body :: proc(shapeId: Shape_Id) -> Body_Id ---

	/// Get the world that owns this shape
	@(link_name="b2Shape_GetWorld")
	shape_get_world :: proc(shapeId: Shape_Id) -> World_Id ---

	/// Returns true If the shape is a sensor
	@(link_name="b2Shape_IsSensor")
	shape_is_sensor :: proc(shapeId: Shape_Id) -> bool ---

	/// Set the user data for a shape
	@(link_name="b2Shape_SetUserData")
	shape_set_user_data :: proc(shapeId: Shape_Id, userData: rawptr) ---

	/// Get the user data for a shape. This is useful when you get a shape id
	/// from an event or query.
	@(link_name="b2Shape_GetUserData")
	shape_get_user_data :: proc(shapeId: Shape_Id) -> rawptr ---

	/// Set the mass density of a shape, usually in kg/m^2.
	/// This will optionally update the mass properties on the parent body.
	/// @see b2ShapeDef::density, b2Body_ApplyMassFromShapes
	@(link_name="b2Shape_SetDensity")
	shape_set_density :: proc(shapeId: Shape_Id, density: f32, updateBodyMass: bool) ---

	/// Get the density of a shape, usually in kg/m^2
	@(link_name="b2Shape_GetDensity")
	shape_get_density :: proc(shapeId: Shape_Id) -> f32 ---

	/// Set the friction on a shape
	/// @see b2ShapeDef::friction
	@(link_name="b2Shape_SetFriction")
	shape_set_friction :: proc(shapeId: Shape_Id, friction: f32) ---

	/// Get the friction of a shape
	@(link_name="b2Shape_GetFriction")
	shape_get_friction :: proc(shapeId: Shape_Id) -> f32 ---

	/// Set the shape restitution (bounciness)
	/// @see b2ShapeDef::restitution
	@(link_name="b2Shape_SetRestitution")
	shape_set_restitution :: proc(shapeId: Shape_Id, restitution: f32) ---

	/// Get the shape restitution
	@(link_name="b2Shape_GetRestitution")
	shape_get_restitution :: proc(shapeId: Shape_Id) -> f32 ---

	/// Set the shape material identifier
	/// @see b2ShapeDef::material
	@(link_name="b2Shape_SetMaterial")
	shape_set_material :: proc(shapeId: Shape_Id, material: i32) ---

	/// Get the shape material identifier
	@(link_name="b2Shape_GetMaterial")
	shape_get_material :: proc(shapeId: Shape_Id) -> i32 ---

	/// Get the shape filter
	@(link_name="b2Shape_GetFilter")
	shape_get_filter :: proc(shapeId: Shape_Id) -> Filter ---

	/// Set the current filter. This is almost as expensive as recreating the shape. This may cause
	/// contacts to be immediately destroyed. However contacts are not created until the next world step.
	/// Sensor overlap state is also not updated until the next world step.
	/// @see b2ShapeDef::filter
	@(link_name="b2Shape_SetFilter")
	shape_set_filter :: proc(shapeId: Shape_Id, filter: Filter) ---

	/// Enable contact events for this shape. Only applies to kinematic and dynamic bodies. Ignored for sensors.
	/// @see b2ShapeDef::enableContactEvents
	/// @warning changing this at run-time may lead to lost begin/end events
	@(link_name="b2Shape_EnableContactEvents")
	shape_enable_contact_events :: proc(shapeId: Shape_Id, flag: bool) ---

	/// Returns true if contact events are enabled
	@(link_name="b2Shape_AreContactEventsEnabled")
	shape_are_contact_events_enabled :: proc(shapeId: Shape_Id) -> bool ---

	/// Enable pre-solve contact events for this shape. Only applies to dynamic bodies. These are expensive
	/// and must be carefully handled due to multithreading. Ignored for sensors.
	/// @see b2PreSolveFcn
	@(link_name="b2Shape_EnablePreSolveEvents")
	shape_enable_pre_solve_events :: proc(shapeId: Shape_Id, flag: bool) ---

	/// Returns true if pre-solve events are enabled
	@(link_name="b2Shape_ArePreSolveEventsEnabled")
	shape_are_pre_solve_events_enabled :: proc(shapeId: Shape_Id) -> bool ---

	/// Enable contact hit events for this shape. Ignored for sensors.
	/// @see b2WorldDef.hitEventThreshold
	@(link_name="b2Shape_EnableHitEvents")
	shape_enable_hit_events :: proc(shapeId: Shape_Id, flag: bool) ---

	/// Returns true if hit events are enabled
	@(link_name="b2Shape_AreHitEventsEnabled")
	shape_are_hit_events_enabled :: proc(shapeId: Shape_Id) -> bool ---

	/// Test a point for overlap with a shape
	@(link_name="b2Shape_TestPoint")
	shape_test_point :: proc(shapeId: Shape_Id, point: Vec2) -> bool ---

	/// Ray cast a shape directly
	@(link_name="b2Shape_RayCast")
	shape_ray_cast :: proc(shapeId: Shape_Id, input: ^Ray_Cast_Input) -> Cast_Output ---

	/// Get a copy of the shape's circle. Asserts the type is correct.
	@(link_name="b2Shape_GetCircle")
	shape_get_circle :: proc(shapeId: Shape_Id) -> Circle ---

	/// Get a copy of the shape's line segment. Asserts the type is correct.
	@(link_name="b2Shape_GetSegment")
	shape_get_segment :: proc(shapeId: Shape_Id) -> Segment ---

	/// Get a copy of the shape's chain segment. These come from chain shapes.
	/// Asserts the type is correct.
	@(link_name="b2Shape_GetChainSegment")
	shape_get_chain_segment :: proc(shapeId: Shape_Id) -> Chain_Segment ---

	/// Get a copy of the shape's capsule. Asserts the type is correct.
	@(link_name="b2Shape_GetCapsule")
	shape_get_capsule :: proc(shapeId: Shape_Id) -> Capsule ---

	/// Get a copy of the shape's convex polygon. Asserts the type is correct.
	@(link_name="b2Shape_GetPolygon")
	shape_get_polygon :: proc(shapeId: Shape_Id) -> Polygon ---

	/// Allows you to change a shape to be a circle or update the current circle.
	/// This does not modify the mass properties.
	/// @see b2Body_ApplyMassFromShapes
	@(link_name="b2Shape_SetCircle")
	shape_set_circle :: proc(shapeId: Shape_Id, circle: ^Circle) ---

	/// Allows you to change a shape to be a capsule or update the current capsule.
	/// This does not modify the mass properties.
	/// @see b2Body_ApplyMassFromShapes
	@(link_name="b2Shape_SetCapsule")
	shape_set_capsule :: proc(shapeId: Shape_Id, capsule: ^Capsule) ---

	/// Allows you to change a shape to be a segment or update the current segment.
	@(link_name="b2Shape_SetSegment")
	shape_set_segment :: proc(shapeId: Shape_Id, segment: ^Segment) ---

	/// Allows you to change a shape to be a polygon or update the current polygon.
	/// This does not modify the mass properties.
	/// @see b2Body_ApplyMassFromShapes
	@(link_name="b2Shape_SetPolygon")
	shape_set_polygon :: proc(shapeId: Shape_Id, polygon: ^Polygon) ---

	/// Get the parent chain id if the shape type is a chain segment, otherwise
	/// returns b2_nullChainId.
	@(link_name="b2Shape_GetParentChain")
	shape_get_parent_chain :: proc(shapeId: Shape_Id) -> Chain_Id ---

	/// Get the maximum capacity required for retrieving all the touching contacts on a shape
	@(link_name="b2Shape_GetContactCapacity")
	shape_get_contact_capacity :: proc(shapeId: Shape_Id) -> i32 ---

	/// Get the touching contact data for a shape. The provided shapeId will be either shapeIdA or shapeIdB on the contact data.
	/// @note Box2D uses speculative collision so some contact points may be separated.
	/// @returns the number of elements filled in the provided array
	/// @warning do not ignore the return value, it specifies the valid number of elements
	@(link_name="b2Shape_GetContactData")
	shape_get_contact_data :: proc(shapeId: Shape_Id, contactData: ^Contact_Data, capacity: i32) -> i32 ---

	/// Get the maximum capacity required for retrieving all the overlapped shapes on a sensor shape.
	/// This returns 0 if the provided shape is not a sensor.
	/// @param shapeId the id of a sensor shape
	/// @returns the required capacity to get all the overlaps in b2Shape_GetSensorOverlaps
	@(link_name="b2Shape_GetSensorCapacity")
	shape_get_sensor_capacity :: proc(shapeId: Shape_Id) -> i32 ---

	/// Get the overlapped shapes for a sensor shape.
	/// @param shapeId the id of a sensor shape
	/// @param overlaps a user allocated array that is filled with the overlapping shapes
	/// @param capacity the capacity of overlappedShapes
	/// @returns the number of elements filled in the provided array
	/// @warning do not ignore the return value, it specifies the valid number of elements
	/// @warning overlaps may contain destroyed shapes so use b2Shape_IsValid to confirm each overlap
	@(link_name="b2Shape_GetSensorOverlaps")
	shape_get_sensor_overlaps :: proc(shapeId: Shape_Id, overlaps: ^Shape_Id, capacity: i32) -> i32 ---

	/// Get the current world AABB
	@(link_name="b2Shape_GetAABB")
	shape_get_aabb :: proc(shapeId: Shape_Id) -> Aabb ---

	/// Get the mass data for a shape
	@(link_name="b2Shape_GetMassData")
	shape_get_mass_data :: proc(shapeId: Shape_Id) -> Mass_Data ---

	/// Get the closest point on a shape to a target point. Target and result are in world space.
	/// todo need sample
	@(link_name="b2Shape_GetClosestPoint")
	shape_get_closest_point :: proc(shapeId: Shape_Id, target: Vec2) -> Vec2 ---

	/// Create a chain shape
	/// @see b2ChainDef for details
	@(link_name="b2CreateChain")
	create_chain :: proc(bodyId: Body_Id, def: ^Chain_Def) -> Chain_Id ---

	/// Destroy a chain shape
	@(link_name="b2DestroyChain")
	destroy_chain :: proc(chainId: Chain_Id) ---

	/// Get the world that owns this chain shape
	@(link_name="b2Chain_GetWorld")
	chain_get_world :: proc(chainId: Chain_Id) -> World_Id ---

	/// Get the number of segments on this chain
	@(link_name="b2Chain_GetSegmentCount")
	chain_get_segment_count :: proc(chainId: Chain_Id) -> i32 ---

	/// Fill a user array with chain segment shape ids up to the specified capacity. Returns
	/// the actual number of segments returned.
	@(link_name="b2Chain_GetSegments")
	chain_get_segments :: proc(chainId: Chain_Id, segmentArray: ^Shape_Id, capacity: i32) -> i32 ---

	/// Set the chain friction
	/// @see b2ChainDef::friction
	@(link_name="b2Chain_SetFriction")
	chain_set_friction :: proc(chainId: Chain_Id, friction: f32) ---

	/// Get the chain friction
	@(link_name="b2Chain_GetFriction")
	chain_get_friction :: proc(chainId: Chain_Id) -> f32 ---

	/// Set the chain restitution (bounciness)
	/// @see b2ChainDef::restitution
	@(link_name="b2Chain_SetRestitution")
	chain_set_restitution :: proc(chainId: Chain_Id, restitution: f32) ---

	/// Get the chain restitution
	@(link_name="b2Chain_GetRestitution")
	chain_get_restitution :: proc(chainId: Chain_Id) -> f32 ---

	/// Set the chain material
	/// @see b2ChainDef::material
	@(link_name="b2Chain_SetMaterial")
	chain_set_material :: proc(chainId: Chain_Id, material: i32) ---

	/// Get the chain material
	@(link_name="b2Chain_GetMaterial")
	chain_get_material :: proc(chainId: Chain_Id) -> i32 ---

	/// Chain identifier validation. Provides validation for up to 64K allocations.
	@(link_name="b2Chain_IsValid")
	chain_is_valid :: proc(id: Chain_Id) -> bool ---

	/// Destroy a joint
	@(link_name="b2DestroyJoint")
	destroy_joint :: proc(jointId: Joint_Id) ---

	/// Joint identifier validation. Provides validation for up to 64K allocations.
	@(link_name="b2Joint_IsValid")
	joint_is_valid :: proc(id: Joint_Id) -> bool ---

	/// Get the joint type
	@(link_name="b2Joint_GetType")
	joint_get_type :: proc(jointId: Joint_Id) -> Joint_Type ---

	/// Get body A id on a joint
	@(link_name="b2Joint_GetBodyA")
	joint_get_body_a :: proc(jointId: Joint_Id) -> Body_Id ---

	/// Get body B id on a joint
	@(link_name="b2Joint_GetBodyB")
	joint_get_body_b :: proc(jointId: Joint_Id) -> Body_Id ---

	/// Get the world that owns this joint
	@(link_name="b2Joint_GetWorld")
	joint_get_world :: proc(jointId: Joint_Id) -> World_Id ---

	/// Get the local anchor on bodyA
	@(link_name="b2Joint_GetLocalAnchorA")
	joint_get_local_anchor_a :: proc(jointId: Joint_Id) -> Vec2 ---

	/// Get the local anchor on bodyB
	@(link_name="b2Joint_GetLocalAnchorB")
	joint_get_local_anchor_b :: proc(jointId: Joint_Id) -> Vec2 ---

	/// Toggle collision between connected bodies
	@(link_name="b2Joint_SetCollideConnected")
	joint_set_collide_connected :: proc(jointId: Joint_Id, shouldCollide: bool) ---

	/// Is collision allowed between connected bodies?
	@(link_name="b2Joint_GetCollideConnected")
	joint_get_collide_connected :: proc(jointId: Joint_Id) -> bool ---

	/// Set the user data on a joint
	@(link_name="b2Joint_SetUserData")
	joint_set_user_data :: proc(jointId: Joint_Id, userData: rawptr) ---

	/// Get the user data on a joint
	@(link_name="b2Joint_GetUserData")
	joint_get_user_data :: proc(jointId: Joint_Id) -> rawptr ---

	/// Wake the bodies connect to this joint
	@(link_name="b2Joint_WakeBodies")
	joint_wake_bodies :: proc(jointId: Joint_Id) ---

	/// Get the current constraint force for this joint. Usually in Newtons.
	@(link_name="b2Joint_GetConstraintForce")
	joint_get_constraint_force :: proc(jointId: Joint_Id) -> Vec2 ---

	/// Get the current constraint torque for this joint. Usually in Newton * meters.
	@(link_name="b2Joint_GetConstraintTorque")
	joint_get_constraint_torque :: proc(jointId: Joint_Id) -> f32 ---

	/// Create a distance joint
	/// @see b2DistanceJointDef for details
	@(link_name="b2CreateDistanceJoint")
	create_distance_joint :: proc(worldId: World_Id, def: ^Distance_Joint_Def) -> Joint_Id ---

	/// Set the rest length of a distance joint
	/// @param jointId The id for a distance joint
	/// @param length The new distance joint length
	@(link_name="b2DistanceJoint_SetLength")
	distance_joint_set_length :: proc(jointId: Joint_Id, length: f32) ---

	/// Get the rest length of a distance joint
	@(link_name="b2DistanceJoint_GetLength")
	distance_joint_get_length :: proc(jointId: Joint_Id) -> f32 ---

	/// Enable/disable the distance joint spring. When disabled the distance joint is rigid.
	@(link_name="b2DistanceJoint_EnableSpring")
	distance_joint_enable_spring :: proc(jointId: Joint_Id, enableSpring: bool) ---

	/// Is the distance joint spring enabled?
	@(link_name="b2DistanceJoint_IsSpringEnabled")
	distance_joint_is_spring_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the spring stiffness in Hertz
	@(link_name="b2DistanceJoint_SetSpringHertz")
	distance_joint_set_spring_hertz :: proc(jointId: Joint_Id, hertz: f32) ---

	/// Set the spring damping ratio, non-dimensional
	@(link_name="b2DistanceJoint_SetSpringDampingRatio")
	distance_joint_set_spring_damping_ratio :: proc(jointId: Joint_Id, dampingRatio: f32) ---

	/// Get the spring Hertz
	@(link_name="b2DistanceJoint_GetSpringHertz")
	distance_joint_get_spring_hertz :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the spring damping ratio
	@(link_name="b2DistanceJoint_GetSpringDampingRatio")
	distance_joint_get_spring_damping_ratio :: proc(jointId: Joint_Id) -> f32 ---

	/// Enable joint limit. The limit only works if the joint spring is enabled. Otherwise the joint is rigid
	/// and the limit has no effect.
	@(link_name="b2DistanceJoint_EnableLimit")
	distance_joint_enable_limit :: proc(jointId: Joint_Id, enableLimit: bool) ---

	/// Is the distance joint limit enabled?
	@(link_name="b2DistanceJoint_IsLimitEnabled")
	distance_joint_is_limit_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the minimum and maximum length parameters of a distance joint
	@(link_name="b2DistanceJoint_SetLengthRange")
	distance_joint_set_length_range :: proc(jointId: Joint_Id, minLength: f32, maxLength: f32) ---

	/// Get the distance joint minimum length
	@(link_name="b2DistanceJoint_GetMinLength")
	distance_joint_get_min_length :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the distance joint maximum length
	@(link_name="b2DistanceJoint_GetMaxLength")
	distance_joint_get_max_length :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the current length of a distance joint
	@(link_name="b2DistanceJoint_GetCurrentLength")
	distance_joint_get_current_length :: proc(jointId: Joint_Id) -> f32 ---

	/// Enable/disable the distance joint motor
	@(link_name="b2DistanceJoint_EnableMotor")
	distance_joint_enable_motor :: proc(jointId: Joint_Id, enableMotor: bool) ---

	/// Is the distance joint motor enabled?
	@(link_name="b2DistanceJoint_IsMotorEnabled")
	distance_joint_is_motor_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the distance joint motor speed, usually in meters per second
	@(link_name="b2DistanceJoint_SetMotorSpeed")
	distance_joint_set_motor_speed :: proc(jointId: Joint_Id, motorSpeed: f32) ---

	/// Get the distance joint motor speed, usually in meters per second
	@(link_name="b2DistanceJoint_GetMotorSpeed")
	distance_joint_get_motor_speed :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the distance joint maximum motor force, usually in newtons
	@(link_name="b2DistanceJoint_SetMaxMotorForce")
	distance_joint_set_max_motor_force :: proc(jointId: Joint_Id, force: f32) ---

	/// Get the distance joint maximum motor force, usually in newtons
	@(link_name="b2DistanceJoint_GetMaxMotorForce")
	distance_joint_get_max_motor_force :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the distance joint current motor force, usually in newtons
	@(link_name="b2DistanceJoint_GetMotorForce")
	distance_joint_get_motor_force :: proc(jointId: Joint_Id) -> f32 ---

	/// Create a motor joint
	/// @see b2MotorJointDef for details
	@(link_name="b2CreateMotorJoint")
	create_motor_joint :: proc(worldId: World_Id, def: ^Motor_Joint_Def) -> Joint_Id ---

	/// Set the motor joint linear offset target
	@(link_name="b2MotorJoint_SetLinearOffset")
	motor_joint_set_linear_offset :: proc(jointId: Joint_Id, linearOffset: Vec2) ---

	/// Get the motor joint linear offset target
	@(link_name="b2MotorJoint_GetLinearOffset")
	motor_joint_get_linear_offset :: proc(jointId: Joint_Id) -> Vec2 ---

	/// Set the motor joint angular offset target in radians
	@(link_name="b2MotorJoint_SetAngularOffset")
	motor_joint_set_angular_offset :: proc(jointId: Joint_Id, angularOffset: f32) ---

	/// Get the motor joint angular offset target in radians
	@(link_name="b2MotorJoint_GetAngularOffset")
	motor_joint_get_angular_offset :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the motor joint maximum force, usually in newtons
	@(link_name="b2MotorJoint_SetMaxForce")
	motor_joint_set_max_force :: proc(jointId: Joint_Id, maxForce: f32) ---

	/// Get the motor joint maximum force, usually in newtons
	@(link_name="b2MotorJoint_GetMaxForce")
	motor_joint_get_max_force :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the motor joint maximum torque, usually in newton-meters
	@(link_name="b2MotorJoint_SetMaxTorque")
	motor_joint_set_max_torque :: proc(jointId: Joint_Id, maxTorque: f32) ---

	/// Get the motor joint maximum torque, usually in newton-meters
	@(link_name="b2MotorJoint_GetMaxTorque")
	motor_joint_get_max_torque :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the motor joint correction factor, usually in [0, 1]
	@(link_name="b2MotorJoint_SetCorrectionFactor")
	motor_joint_set_correction_factor :: proc(jointId: Joint_Id, correctionFactor: f32) ---

	/// Get the motor joint correction factor, usually in [0, 1]
	@(link_name="b2MotorJoint_GetCorrectionFactor")
	motor_joint_get_correction_factor :: proc(jointId: Joint_Id) -> f32 ---

	/// Create a mouse joint
	/// @see b2MouseJointDef for details
	@(link_name="b2CreateMouseJoint")
	create_mouse_joint :: proc(worldId: World_Id, def: ^Mouse_Joint_Def) -> Joint_Id ---

	/// Set the mouse joint target
	@(link_name="b2MouseJoint_SetTarget")
	mouse_joint_set_target :: proc(jointId: Joint_Id, target: Vec2) ---

	/// Get the mouse joint target
	@(link_name="b2MouseJoint_GetTarget")
	mouse_joint_get_target :: proc(jointId: Joint_Id) -> Vec2 ---

	/// Set the mouse joint spring stiffness in Hertz
	@(link_name="b2MouseJoint_SetSpringHertz")
	mouse_joint_set_spring_hertz :: proc(jointId: Joint_Id, hertz: f32) ---

	/// Get the mouse joint spring stiffness in Hertz
	@(link_name="b2MouseJoint_GetSpringHertz")
	mouse_joint_get_spring_hertz :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the mouse joint spring damping ratio, non-dimensional
	@(link_name="b2MouseJoint_SetSpringDampingRatio")
	mouse_joint_set_spring_damping_ratio :: proc(jointId: Joint_Id, dampingRatio: f32) ---

	/// Get the mouse joint damping ratio, non-dimensional
	@(link_name="b2MouseJoint_GetSpringDampingRatio")
	mouse_joint_get_spring_damping_ratio :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the mouse joint maximum force, usually in newtons
	@(link_name="b2MouseJoint_SetMaxForce")
	mouse_joint_set_max_force :: proc(jointId: Joint_Id, maxForce: f32) ---

	/// Get the mouse joint maximum force, usually in newtons
	@(link_name="b2MouseJoint_GetMaxForce")
	mouse_joint_get_max_force :: proc(jointId: Joint_Id) -> f32 ---

	/// Create a null joint.
	/// @see b2NullJointDef for details
	@(link_name="b2CreateNullJoint")
	create_null_joint :: proc(worldId: World_Id, def: ^Null_Joint_Def) -> Joint_Id ---

	/// Create a prismatic (slider) joint.
	/// @see b2PrismaticJointDef for details
	@(link_name="b2CreatePrismaticJoint")
	create_prismatic_joint :: proc(worldId: World_Id, def: ^Prismatic_Joint_Def) -> Joint_Id ---

	/// Enable/disable the joint spring.
	@(link_name="b2PrismaticJoint_EnableSpring")
	prismatic_joint_enable_spring :: proc(jointId: Joint_Id, enableSpring: bool) ---

	/// Is the prismatic joint spring enabled or not?
	@(link_name="b2PrismaticJoint_IsSpringEnabled")
	prismatic_joint_is_spring_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the prismatic joint stiffness in Hertz.
	/// This should usually be less than a quarter of the simulation rate. For example, if the simulation
	/// runs at 60Hz then the joint stiffness should be 15Hz or less.
	@(link_name="b2PrismaticJoint_SetSpringHertz")
	prismatic_joint_set_spring_hertz :: proc(jointId: Joint_Id, hertz: f32) ---

	/// Get the prismatic joint stiffness in Hertz
	@(link_name="b2PrismaticJoint_GetSpringHertz")
	prismatic_joint_get_spring_hertz :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the prismatic joint damping ratio (non-dimensional)
	@(link_name="b2PrismaticJoint_SetSpringDampingRatio")
	prismatic_joint_set_spring_damping_ratio :: proc(jointId: Joint_Id, dampingRatio: f32) ---

	/// Get the prismatic spring damping ratio (non-dimensional)
	@(link_name="b2PrismaticJoint_GetSpringDampingRatio")
	prismatic_joint_get_spring_damping_ratio :: proc(jointId: Joint_Id) -> f32 ---

	/// Enable/disable a prismatic joint limit
	@(link_name="b2PrismaticJoint_EnableLimit")
	prismatic_joint_enable_limit :: proc(jointId: Joint_Id, enableLimit: bool) ---

	/// Is the prismatic joint limit enabled?
	@(link_name="b2PrismaticJoint_IsLimitEnabled")
	prismatic_joint_is_limit_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Get the prismatic joint lower limit
	@(link_name="b2PrismaticJoint_GetLowerLimit")
	prismatic_joint_get_lower_limit :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the prismatic joint upper limit
	@(link_name="b2PrismaticJoint_GetUpperLimit")
	prismatic_joint_get_upper_limit :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the prismatic joint limits
	@(link_name="b2PrismaticJoint_SetLimits")
	prismatic_joint_set_limits :: proc(jointId: Joint_Id, lower: f32, upper: f32) ---

	/// Enable/disable a prismatic joint motor
	@(link_name="b2PrismaticJoint_EnableMotor")
	prismatic_joint_enable_motor :: proc(jointId: Joint_Id, enableMotor: bool) ---

	/// Is the prismatic joint motor enabled?
	@(link_name="b2PrismaticJoint_IsMotorEnabled")
	prismatic_joint_is_motor_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the prismatic joint motor speed, usually in meters per second
	@(link_name="b2PrismaticJoint_SetMotorSpeed")
	prismatic_joint_set_motor_speed :: proc(jointId: Joint_Id, motorSpeed: f32) ---

	/// Get the prismatic joint motor speed, usually in meters per second
	@(link_name="b2PrismaticJoint_GetMotorSpeed")
	prismatic_joint_get_motor_speed :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the prismatic joint maximum motor force, usually in newtons
	@(link_name="b2PrismaticJoint_SetMaxMotorForce")
	prismatic_joint_set_max_motor_force :: proc(jointId: Joint_Id, force: f32) ---

	/// Get the prismatic joint maximum motor force, usually in newtons
	@(link_name="b2PrismaticJoint_GetMaxMotorForce")
	prismatic_joint_get_max_motor_force :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the prismatic joint current motor force, usually in newtons
	@(link_name="b2PrismaticJoint_GetMotorForce")
	prismatic_joint_get_motor_force :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the current joint translation, usually in meters.
	@(link_name="b2PrismaticJoint_GetTranslation")
	prismatic_joint_get_translation :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the current joint translation speed, usually in meters per second.
	@(link_name="b2PrismaticJoint_GetSpeed")
	prismatic_joint_get_speed :: proc(jointId: Joint_Id) -> f32 ---

	/// Create a revolute joint
	/// @see b2RevoluteJointDef for details
	@(link_name="b2CreateRevoluteJoint")
	create_revolute_joint :: proc(worldId: World_Id, def: ^Revolute_Joint_Def) -> Joint_Id ---

	/// Enable/disable the revolute joint spring
	@(link_name="b2RevoluteJoint_EnableSpring")
	revolute_joint_enable_spring :: proc(jointId: Joint_Id, enableSpring: bool) ---

	/// It the revolute angular spring enabled?
	@(link_name="b2RevoluteJoint_IsSpringEnabled")
	revolute_joint_is_spring_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the revolute joint spring stiffness in Hertz
	@(link_name="b2RevoluteJoint_SetSpringHertz")
	revolute_joint_set_spring_hertz :: proc(jointId: Joint_Id, hertz: f32) ---

	/// Get the revolute joint spring stiffness in Hertz
	@(link_name="b2RevoluteJoint_GetSpringHertz")
	revolute_joint_get_spring_hertz :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the revolute joint spring damping ratio, non-dimensional
	@(link_name="b2RevoluteJoint_SetSpringDampingRatio")
	revolute_joint_set_spring_damping_ratio :: proc(jointId: Joint_Id, dampingRatio: f32) ---

	/// Get the revolute joint spring damping ratio, non-dimensional
	@(link_name="b2RevoluteJoint_GetSpringDampingRatio")
	revolute_joint_get_spring_damping_ratio :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the revolute joint current angle in radians relative to the reference angle
	/// @see b2RevoluteJointDef::referenceAngle
	@(link_name="b2RevoluteJoint_GetAngle")
	revolute_joint_get_angle :: proc(jointId: Joint_Id) -> f32 ---

	/// Enable/disable the revolute joint limit
	@(link_name="b2RevoluteJoint_EnableLimit")
	revolute_joint_enable_limit :: proc(jointId: Joint_Id, enableLimit: bool) ---

	/// Is the revolute joint limit enabled?
	@(link_name="b2RevoluteJoint_IsLimitEnabled")
	revolute_joint_is_limit_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Get the revolute joint lower limit in radians
	@(link_name="b2RevoluteJoint_GetLowerLimit")
	revolute_joint_get_lower_limit :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the revolute joint upper limit in radians
	@(link_name="b2RevoluteJoint_GetUpperLimit")
	revolute_joint_get_upper_limit :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the revolute joint limits in radians
	@(link_name="b2RevoluteJoint_SetLimits")
	revolute_joint_set_limits :: proc(jointId: Joint_Id, lower: f32, upper: f32) ---

	/// Enable/disable a revolute joint motor
	@(link_name="b2RevoluteJoint_EnableMotor")
	revolute_joint_enable_motor :: proc(jointId: Joint_Id, enableMotor: bool) ---

	/// Is the revolute joint motor enabled?
	@(link_name="b2RevoluteJoint_IsMotorEnabled")
	revolute_joint_is_motor_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the revolute joint motor speed in radians per second
	@(link_name="b2RevoluteJoint_SetMotorSpeed")
	revolute_joint_set_motor_speed :: proc(jointId: Joint_Id, motorSpeed: f32) ---

	/// Get the revolute joint motor speed in radians per second
	@(link_name="b2RevoluteJoint_GetMotorSpeed")
	revolute_joint_get_motor_speed :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the revolute joint current motor torque, usually in newton-meters
	@(link_name="b2RevoluteJoint_GetMotorTorque")
	revolute_joint_get_motor_torque :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the revolute joint maximum motor torque, usually in newton-meters
	@(link_name="b2RevoluteJoint_SetMaxMotorTorque")
	revolute_joint_set_max_motor_torque :: proc(jointId: Joint_Id, torque: f32) ---

	/// Get the revolute joint maximum motor torque, usually in newton-meters
	@(link_name="b2RevoluteJoint_GetMaxMotorTorque")
	revolute_joint_get_max_motor_torque :: proc(jointId: Joint_Id) -> f32 ---

	/// Create a weld joint
	/// @see b2WeldJointDef for details
	@(link_name="b2CreateWeldJoint")
	create_weld_joint :: proc(worldId: World_Id, def: ^Weld_Joint_Def) -> Joint_Id ---

	/// Get the weld joint reference angle in radians
	@(link_name="b2WeldJoint_GetReferenceAngle")
	weld_joint_get_reference_angle :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the weld joint reference angle in radians, must be in [-pi,pi].
	@(link_name="b2WeldJoint_SetReferenceAngle")
	weld_joint_set_reference_angle :: proc(jointId: Joint_Id, angleInRadians: f32) ---

	/// Set the weld joint linear stiffness in Hertz. 0 is rigid.
	@(link_name="b2WeldJoint_SetLinearHertz")
	weld_joint_set_linear_hertz :: proc(jointId: Joint_Id, hertz: f32) ---

	/// Get the weld joint linear stiffness in Hertz
	@(link_name="b2WeldJoint_GetLinearHertz")
	weld_joint_get_linear_hertz :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the weld joint linear damping ratio (non-dimensional)
	@(link_name="b2WeldJoint_SetLinearDampingRatio")
	weld_joint_set_linear_damping_ratio :: proc(jointId: Joint_Id, dampingRatio: f32) ---

	/// Get the weld joint linear damping ratio (non-dimensional)
	@(link_name="b2WeldJoint_GetLinearDampingRatio")
	weld_joint_get_linear_damping_ratio :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the weld joint angular stiffness in Hertz. 0 is rigid.
	@(link_name="b2WeldJoint_SetAngularHertz")
	weld_joint_set_angular_hertz :: proc(jointId: Joint_Id, hertz: f32) ---

	/// Get the weld joint angular stiffness in Hertz
	@(link_name="b2WeldJoint_GetAngularHertz")
	weld_joint_get_angular_hertz :: proc(jointId: Joint_Id) -> f32 ---

	/// Set weld joint angular damping ratio, non-dimensional
	@(link_name="b2WeldJoint_SetAngularDampingRatio")
	weld_joint_set_angular_damping_ratio :: proc(jointId: Joint_Id, dampingRatio: f32) ---

	/// Get the weld joint angular damping ratio, non-dimensional
	@(link_name="b2WeldJoint_GetAngularDampingRatio")
	weld_joint_get_angular_damping_ratio :: proc(jointId: Joint_Id) -> f32 ---

	/// Create a wheel joint
	/// @see b2WheelJointDef for details
	@(link_name="b2CreateWheelJoint")
	create_wheel_joint :: proc(worldId: World_Id, def: ^Wheel_Joint_Def) -> Joint_Id ---

	/// Enable/disable the wheel joint spring
	@(link_name="b2WheelJoint_EnableSpring")
	wheel_joint_enable_spring :: proc(jointId: Joint_Id, enableSpring: bool) ---

	/// Is the wheel joint spring enabled?
	@(link_name="b2WheelJoint_IsSpringEnabled")
	wheel_joint_is_spring_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the wheel joint stiffness in Hertz
	@(link_name="b2WheelJoint_SetSpringHertz")
	wheel_joint_set_spring_hertz :: proc(jointId: Joint_Id, hertz: f32) ---

	/// Get the wheel joint stiffness in Hertz
	@(link_name="b2WheelJoint_GetSpringHertz")
	wheel_joint_get_spring_hertz :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the wheel joint damping ratio, non-dimensional
	@(link_name="b2WheelJoint_SetSpringDampingRatio")
	wheel_joint_set_spring_damping_ratio :: proc(jointId: Joint_Id, dampingRatio: f32) ---

	/// Get the wheel joint damping ratio, non-dimensional
	@(link_name="b2WheelJoint_GetSpringDampingRatio")
	wheel_joint_get_spring_damping_ratio :: proc(jointId: Joint_Id) -> f32 ---

	/// Enable/disable the wheel joint limit
	@(link_name="b2WheelJoint_EnableLimit")
	wheel_joint_enable_limit :: proc(jointId: Joint_Id, enableLimit: bool) ---

	/// Is the wheel joint limit enabled?
	@(link_name="b2WheelJoint_IsLimitEnabled")
	wheel_joint_is_limit_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Get the wheel joint lower limit
	@(link_name="b2WheelJoint_GetLowerLimit")
	wheel_joint_get_lower_limit :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the wheel joint upper limit
	@(link_name="b2WheelJoint_GetUpperLimit")
	wheel_joint_get_upper_limit :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the wheel joint limits
	@(link_name="b2WheelJoint_SetLimits")
	wheel_joint_set_limits :: proc(jointId: Joint_Id, lower: f32, upper: f32) ---

	/// Enable/disable the wheel joint motor
	@(link_name="b2WheelJoint_EnableMotor")
	wheel_joint_enable_motor :: proc(jointId: Joint_Id, enableMotor: bool) ---

	/// Is the wheel joint motor enabled?
	@(link_name="b2WheelJoint_IsMotorEnabled")
	wheel_joint_is_motor_enabled :: proc(jointId: Joint_Id) -> bool ---

	/// Set the wheel joint motor speed in radians per second
	@(link_name="b2WheelJoint_SetMotorSpeed")
	wheel_joint_set_motor_speed :: proc(jointId: Joint_Id, motorSpeed: f32) ---

	/// Get the wheel joint motor speed in radians per second
	@(link_name="b2WheelJoint_GetMotorSpeed")
	wheel_joint_get_motor_speed :: proc(jointId: Joint_Id) -> f32 ---

	/// Set the wheel joint maximum motor torque, usually in newton-meters
	@(link_name="b2WheelJoint_SetMaxMotorTorque")
	wheel_joint_set_max_motor_torque :: proc(jointId: Joint_Id, torque: f32) ---

	/// Get the wheel joint maximum motor torque, usually in newton-meters
	@(link_name="b2WheelJoint_GetMaxMotorTorque")
	wheel_joint_get_max_motor_torque :: proc(jointId: Joint_Id) -> f32 ---

	/// Get the wheel joint current motor torque, usually in newton-meters
	@(link_name="b2WheelJoint_GetMotorTorque")
	wheel_joint_get_motor_torque :: proc(jointId: Joint_Id) -> f32 ---
}

