unit Model.Person.Interfaces;

interface

uses
  System.Generics.Collections, Dto.Person;

type
IModelPerson = interface
  ['{AF1A8875-9000-4A88-A82B-57A9C5FBD38A}']
  function Id(AValue: Int64): IModelPerson;overload;
  function Id: Int64;overload;
  function Nature(AValue: Integer):IModelPerson;overload;
  function Nature: Integer;overload;
  function Document(AValue: String): IModelPerson;overload;
  function Document: String;overload;
  function FirstName(AValue: String): IModelPerson;overload;
  function FirstName: String;overload;
  function LastName(AValue: String): IModelPerson;overload;
  function LastName: String;overload;
  function Cep(AValue: String): IModelPerson;overload;
  function Cep: String;overload;

  procedure CreatePerson;
  function ReadPeople: TList<TPersonDto>;
  procedure UpdatePerson;
  procedure DeletePerson;
end;

implementation

end.
