unit Domain.Abstraction.Viacep;

interface

type
TAbstractionViacep = Class
  private
    FCep: String;
    FLogradouro: String;
    FComplemento: String;
    FBairro: String;
    FLocalidade: String;
    FUf: String;
    FIbge: String;
    FGia: String;
    FDDD: String;
    FSiafi: String;
  public
    property Cep: String read FCep write FCep;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property Localidade: String read FLocalidade write FLocalidade;
    property Uf: String read FUf write FUf;
    property Ibge: String read FIbge write FIbge;
    property Gia: String read FGia write FGia;
    property DDD: String read FDDD write FDDD;
    property Siafi: String read FSiafi write FSiafi;
End;

implementation

end.
