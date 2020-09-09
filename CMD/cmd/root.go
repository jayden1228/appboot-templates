package cmd

import (
	"fmt"
	"os"

	"{{.GitHost}}/{{.GitGroup}}/{{.Name}}/config"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "{{.Name}}",
	Short: "{{.Name}} is a command line tool for {{.Name}} sdk",
	Long:  "{{.Name}} is a command line tool for {{.Name}} sdk",
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

// RootVars struct
// type RootVars struct {
// 	regionId        string
// 	accessKeyId     string
// 	accessKeySecret string
// }

// var rootVars RootVars

func init() {
	cobra.OnInitialize(config.InitConfig)

	// rootCmd.PersistentFlags().StringVarP(&rootVars.accessKeyId, "accessKeyId", "k", "", "the default value is obtained from $HOME/.{{.Name}}/config.yaml")
	// rootCmd.PersistentFlags().StringVarP(&rootVars.accessKeySecret, "accessKeySecret", "s", "", "the default value is obtained from $HOME/.{{.Name}}/config.yaml")
}

// mergeRootVars merge rootVars with config
// func mergeRootVars() {
// 	if len(rootVars.accessKeyId) < 1 {
// 		value, err := config.GetConfig(config.AccessKeyId)
// 		if err == nil && len(value) > 0 {
// 			rootVars.accessKeyId = value
// 		}
// 	}
// 	if len(rootVars.accessKeySecret) < 1 {
// 		value, err := config.GetConfig(config.AccessKeySecret)
// 		if err == nil && len(value) > 0 {
// 			rootVars.accessKeySecret = value
// 		}
// 	}
// }
