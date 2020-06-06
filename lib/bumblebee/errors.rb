module Bumblebee

  class InvalidDataSourceError < RuntimeError; end;

  class InvalidOutputFormatter < RuntimeError; end;

  class FileSystemConnectorFileNotExists < RuntimeError; end;

  class EntityUnregisteredError < RuntimeError; end;

  class UndefinedRule < RuntimeError; end;
end
