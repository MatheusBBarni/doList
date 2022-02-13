type t = {
  id: int,
  name: string,
  completed: bool,
  createdAt: string,
}

let codec = Jzon.object4(
  ({id, name, completed, createdAt}) => (id, name, completed, createdAt),
  ((id, name, completed, createdAt)) =>
    {
      id: id,
      name: name,
      completed: completed,
      createdAt: createdAt,
    }->Ok,
  Jzon.field("id", Jzon.int),
  Jzon.field("name", Jzon.string),
  Jzon.field("completed", Jzon.bool),
  Jzon.field("createdAt", Jzon.string),
)
