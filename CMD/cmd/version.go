package cmd

import (
	"log"

	"github.com/spf13/cobra"
	"{{.GitHost}}/{{.GitGroup}}/{{.Name}}/version"
)

// versionCmd represents the version command
var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "{{.Name}} version",
	Long:  `{{.Name}} version`,
	Run:   runVersionCmd,
}

func runVersionCmd(_ *cobra.Command, _ []string) {
	value := version.GetVersion()
	log.Println(value)
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
