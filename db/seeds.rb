category_images = {
  chest:    "https://images.unsplash.com/photo-1690731033723-ad718c6e585a",
  back:     "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
  legs:     "https://images.unsplash.com/photo-1574680178050-55c6a6a96e0a",
  shoulders: "https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5",
  biceps:   "https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e",
  triceps:  "https://images.unsplash.com/photo-1604480133435-25b86862d276",
  core:     "https://images.unsplash.com/photo-1714646442330-9068099f5521",
  cardio:   "https://images.unsplash.com/photo-1632077804406-188472f1a810"
}

image_params = "?w=320&h=220&fit=crop&auto=format&q=70"

[
  # Chest
  { name: "Bench Press", muscles_target: "Chest, Triceps, Shoulders", category: :chest,
    description: "Lie on a flat bench and press a loaded barbell from your chest to full arm extension. The foundational chest builder." },
  { name: "Incline Bench Press", muscles_target: "Upper Chest, Shoulders, Triceps", category: :chest,
    description: "Same movement as the flat bench press, performed on an incline bench to emphasize the upper chest." },
  { name: "Decline Bench Press", muscles_target: "Lower Chest, Triceps", category: :chest,
    description: "Performed on a decline bench to shift emphasis toward the lower chest." },
  { name: "Push-up", muscles_target: "Chest, Triceps, Shoulders, Core", category: :chest,
    description: "A bodyweight pressing movement performed from a plank position — no equipment required." },
  { name: "Chest Fly", muscles_target: "Chest", category: :chest,
    description: "An isolation movement using dumbbells or cables to stretch and squeeze the chest through a wide arc." },
  { name: "Cable Crossover", muscles_target: "Chest", category: :chest,
    description: "Standing cable movement that brings the arms together in front of the body to isolate the chest." },
  { name: "Dip", muscles_target: "Chest, Triceps", category: :chest,
    description: "Lower and raise your body between parallel bars — a demanding bodyweight press for chest and triceps." },

  # Back
  { name: "Deadlift", muscles_target: "Hamstrings, Glutes, Back", category: :back,
    description: "Lift a loaded barbell from the floor to hip level with a flat back — one of the most complete strength movements." },
  { name: "Barbell Row", muscles_target: "Back, Biceps", category: :back,
    description: "Hinge at the hips and row a barbell to your torso to build thickness across the mid-back." },
  { name: "Pull-up", muscles_target: "Back, Biceps", category: :back,
    description: "Pull your bodyweight up to a bar using an overhand grip — a benchmark upper-body pulling exercise." },
  { name: "Lat Pulldown", muscles_target: "Back, Biceps", category: :back,
    description: "A machine-based pulling movement that mimics the pull-up, useful for building toward a first bodyweight pull-up." },
  { name: "T-Bar Row", muscles_target: "Back, Biceps", category: :back,
    description: "A supported rowing movement that allows heavier loading with less lower-back strain than a barbell row." },
  { name: "Seated Cable Row", muscles_target: "Back, Biceps", category: :back,
    description: "Seated pulling movement performed on a cable machine, emphasizing the mid-back." },
  { name: "Face Pull", muscles_target: "Rear Delts, Upper Back", category: :back,
    description: "A cable movement pulled toward the face that strengthens the rear shoulders and improves posture." },

  # Legs
  { name: "Squat", muscles_target: "Quads, Glutes, Hamstrings", category: :legs,
    description: "Bend the knees and hips to lower a loaded barbell before standing back up — the cornerstone lower-body lift." },
  { name: "Front Squat", muscles_target: "Quads, Core", category: :legs,
    description: "A squat variation with the bar racked across the front of the shoulders, placing more emphasis on the quads." },
  { name: "Leg Press", muscles_target: "Quads, Glutes, Hamstrings", category: :legs,
    description: "A machine-based pressing movement that loads the legs without requiring balance or a loaded spine." },
  { name: "Lunge", muscles_target: "Quads, Glutes", category: :legs,
    description: "Step forward and lower the back knee toward the floor — a unilateral movement that also challenges balance." },
  { name: "Bulgarian Split Squat", muscles_target: "Quads, Glutes", category: :legs,
    description: "A single-leg squat with the rear foot elevated behind you, demanding balance and unilateral strength." },
  { name: "Romanian Deadlift", muscles_target: "Hamstrings, Glutes", category: :legs,
    description: "A hip-hinge movement with minimal knee bend that targets the hamstrings and glutes through a deep stretch." },
  { name: "Leg Curl", muscles_target: "Hamstrings", category: :legs,
    description: "A machine isolation movement that curls the heel toward the glutes to target the hamstrings directly." },
  { name: "Leg Extension", muscles_target: "Quads", category: :legs,
    description: "A machine isolation movement that extends the knee to target the quads directly." },
  { name: "Calf Raise", muscles_target: "Calves", category: :legs,
    description: "Rise onto the toes against resistance to build the calves." },

  # Shoulders
  { name: "Overhead Press", muscles_target: "Shoulders, Triceps", category: :shoulders,
    description: "Press a loaded barbell or dumbbells overhead from shoulder height — a core builder of shoulder strength." },
  { name: "Arnold Press", muscles_target: "Shoulders, Triceps", category: :shoulders,
    description: "A dumbbell press variation that rotates the palms through the movement for fuller shoulder engagement." },
  { name: "Lateral Raise", muscles_target: "Shoulders", category: :shoulders,
    description: "Raise dumbbells out to the sides to isolate the middle deltoid and build shoulder width." },
  { name: "Front Raise", muscles_target: "Shoulders", category: :shoulders,
    description: "Raise a weight in front of the body to isolate the front deltoid." },
  { name: "Rear Delt Fly", muscles_target: "Rear Delts", category: :shoulders,
    description: "Bent-over raises that isolate the rear deltoids, often neglected in pressing-heavy programs." },
  { name: "Upright Row", muscles_target: "Shoulders, Traps", category: :shoulders,
    description: "Pull a bar or dumbbells vertically along the body toward chin height to build the shoulders and traps." },

  # Arms
  { name: "Bicep Curl", muscles_target: "Biceps", category: :biceps,
    description: "Curl a weight from full arm extension to full flexion — the classic bicep isolation movement." },
  { name: "Hammer Curl", muscles_target: "Biceps, Forearms", category: :biceps,
    description: "A curl variation performed with a neutral grip, emphasizing the brachialis and forearms." },
  { name: "Preacher Curl", muscles_target: "Biceps", category: :biceps,
    description: "Curls performed with the arms braced against an angled pad to eliminate momentum and isolate the biceps." },
  { name: "Tricep Pushdown", muscles_target: "Triceps", category: :triceps,
    description: "A cable isolation movement that extends the elbow to target the triceps." },
  { name: "Skull Crusher", muscles_target: "Triceps", category: :triceps,
    description: "Lying elbow extensions that lower a weight toward the forehead — a strong triceps builder." },
  { name: "Close-Grip Bench Press", muscles_target: "Triceps, Chest", category: :triceps,
    description: "A bench press variation with a narrow grip that shifts emphasis onto the triceps." },

  # Core
  { name: "Plank", muscles_target: "Core", category: :core,
    description: "Hold a straight-body position supported on the forearms and toes to build core stability." },
  { name: "Russian Twist", muscles_target: "Obliques, Core", category: :core,
    description: "A seated rotational movement that targets the obliques." },
  { name: "Hanging Leg Raise", muscles_target: "Core, Hip Flexors", category: :core,
    description: "Raise the legs while hanging from a bar to build lower-ab and hip-flexor strength." },
  { name: "Cable Crunch", muscles_target: "Core", category: :core,
    description: "A kneeling cable movement that allows the abs to be loaded through a full range of motion." },
  { name: "Ab Wheel Rollout", muscles_target: "Core", category: :core,
    description: "Roll a wheel forward from a kneeling position and pull back to full flexion — a demanding anti-extension core exercise." },

  # Full body / conditioning
  { name: "Kettlebell Swing", muscles_target: "Glutes, Hamstrings, Core", category: :cardio,
    description: "A hip-hinge power movement that swings a kettlebell using explosive hip drive." },
  { name: "Burpee", muscles_target: "Full Body", category: :cardio,
    description: "A bodyweight movement combining a squat, plank, push-up, and jump — a demanding full-body conditioning exercise." },
  { name: "Clean and Jerk", muscles_target: "Full Body", category: :cardio,
    description: "An Olympic lift that pulls a barbell from the floor to the shoulders, then drives it overhead." },
  { name: "Snatch", muscles_target: "Full Body", category: :cardio,
    description: "An Olympic lift that moves a barbell from the floor to overhead in a single explosive motion." },
  { name: "Farmer's Carry", muscles_target: "Grip, Core, Traps", category: :back,
    description: "Walk for distance while carrying a heavy weight in each hand — builds grip, core, and overall work capacity." }
].each do |attrs|
  exercise = Exercise.find_or_initialize_by(name: attrs[:name])
  exercise.assign_attributes(
    muscles_target: attrs[:muscles_target],
    description: attrs[:description],
    image_url: category_images.fetch(attrs[:category]) + image_params
  )
  exercise.save!
end
