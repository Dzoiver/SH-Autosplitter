// Creator: Seifer
// Thanks to Ero
// This script requires asl-help component

state("SH") {}

startup
{
  vars.maxID = 0;
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
  vars.Helper.GameName = "SuperHot";
}

init
{
  // List of levels ID on which it will split
  vars.LevelID = new List<int>()
	{1,2,3,4,5,7,8,9,10,11,12,15,17,18,19,20,21,22,23,25,26,27,30,31,32,34,36,38,40,42,44,45};
  
  vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
  {
    vars.Helper["ID"] = mono.Make<int>("LevelSetup", "_CurrentLevelInfo", "ID");
    // vars.Helper["PlayerControlled"] = mono.Make<int>("PlayerController", "Instance" ,"PlayerControlled");
    vars.Helper["CurrentGameKills"] = mono.Make<int>("LevelSetup","CurrentGameKills");
    return true;
  });
}

split
{
  // If current ID of the map is bigger than the max and in the list of levels
  if (current.ID > vars.maxID && vars.LevelID.Contains(current.ID))
  {
    vars.maxID = current.ID;
    return true;
  }

  if (current.CurrentGameKills == 1 && old.CurrentGameKills == 0 && current.ID == 47)
  {
    return true;
  }
}

start
{
  // starts when the first map loaded. To make it correct for the timing rules, set the timer to start at 1.93
  if (current.ID > 0 && old.ID == 0)
  {
    vars.maxID = current.ID;
    return true;
  }
}
