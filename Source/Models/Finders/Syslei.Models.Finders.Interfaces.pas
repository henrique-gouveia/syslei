unit Syslei.Models.Finders.Interfaces;

interface

uses
  Spring,
  Spring.Collections;

type
  IEntityFinder<TEntity: class, constructor> = interface
    ['{EE75511A-2D60-4982-B4E5-1370D8858A4F}']
    function FindEqual(const propertyName: String; const propertyValue: TValue): IList<TEntity>;
    function FindLikeAnyware(const propertyName: String; const propertyValue: TValue): IList<TEntity>;
    function FindLikeStart(const propertyName: String; const propertyValue: TValue): IList<TEntity>;
  end;

  IEntityFinder<TEntity, TFilter: class, constructor> = interface
    ['{17ED05BB-51C4-4859-BD4F-96A9773BB538}']
    function Find(const filter: TFilter): IList<TEntity>;
  end;

implementation

end.
