[
  { name: "Bench Press",    muscles_target: "Chest, Triceps, Shoulders" },
  { name: "Squat",          muscles_target: "Quads, Glutes, Hamstrings" },
  { name: "Deadlift",       muscles_target: "Hamstrings, Glutes, Back" },
  { name: "Overhead Press", muscles_target: "Shoulders, Triceps" },
  { name: "Barbell Row",    muscles_target: "Back, Biceps" },
  { name: "Pull-up",        muscles_target: "Back, Biceps" },
  { name: "Dip",            muscles_target: "Chest, Triceps" },
  { name: "Lunge",          muscles_target: "Quads, Glutes" },
  { name: "Bicep Curl",     muscles_target: "Biceps" },
  { name: "Tricep Pushdown", muscles_target: "Triceps" }
].each do |attrs|
  Exercise.find_or_create_by!(name: attrs[:name]) do |e|
    e.muscles_target = attrs[:muscles_target]
  end
end
