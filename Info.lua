g_PluginInfo =
{
	Name = "MagicCarpet",
	Version = "4",
	Date = "2017-02-23",
	SourceLocation = "https://github.com/cuberite/MagicCarpet",
	Description = [[Plugin for Cuberite that creates a magical carpet under you as you walk.]],

	Commands =
	{
		["/magiccarpet"] =
		{
			Alias = "/mc",
			Handler = HandleMagicCarpetCommand,
			Permission = "magiccarpet",
			HelpString = "Creates a magical carpet"
		},
	},
}
