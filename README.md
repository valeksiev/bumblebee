# Bumblebee

Developed as a project for the Ruby Course thought in FMI-SU bumblebee aims to be an example of good, flexible, extensible architecture.

## Concept
The architecture consists of five main layer - connector, adapter, configuration, runner, output_formatter. All but the runner can be extended to fullfill the needs of the developer. An example usage can be found [here](https://github.com/valeksiev/bumblebee/blob/master/spec/bumblebee/integration_spec.rb).

### What is each component responsible for:
- `Connector` - this is used to preare the date source - open a file on the file system, open a db connection, etc
- `Adapter` - this guy takes a connection and knows how to load data - read a file, execute an SQL query and so on; it is responsible to generate data that is in the format which the transform configuration expects
- `Configuration` - an example configuration can be found [here](https://github.com/valeksiev/bumblebee/blob/master/spec/fixtures/configuration.rb). The gem defines two types types of properties for the entites - `field` and `relation`; those can be extended and custom types can be defined
- `Runner` the runner takes the output of an adapter, load the configuration and executed the transformation itself 
- `OutputFormatter` - the output formatter is invoked by the runner and the result of the transofmation is passed to it; it then has to decide what to do with it - write it in a file, store it in a DB or just output it in the console as the default one would do

In order to extend the functionality on any level except for the `Runner` you just need to extend the base classes and define the needed methods.
