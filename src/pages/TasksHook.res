let {queryOptions, useQuery, mutationOptions, useMutation} = module(ReactQuery)

type requestResult =
  | Data(array<TaskTypes.t>)
  | Loading
  | Error

type hookResult = {
  result: requestResult,
  handleChange: ReactEvent.Form.t => unit,
  taskName: string,
  handleCreateTask: ReactEvent.Mouse.t => unit,
  isCreating: bool,
}

let apiUrl = "http://localhost:3001"
let apiCodec = Jzon.array(TaskTypes.codec)

let handleFetch = _ => {
  open Promise

  Fetch.fetch(`${apiUrl}/tasks`, {"method": "GET"})
  ->then(response => Fetch.json(response))
  ->thenResolve(json => json->Jzon.decodeWith(apiCodec))
}

let handleCreateTask = taskName => {
  // open Promise

  let newTask = {
    "name": taskName,
    "completed": false,
    "createdAt": Js.Date.make(),
  }

  Fetch.fetch(
    `${apiUrl}/tasks`,
    {
      "method": "POST",
      "body": newTask->Js.Json.stringifyAny,
      "headers": {
        "Content-type": "application/json",
      },
    },
  )
}

let useTasks = () => {
  let (taskName, setTaskName) = React.useState(_ => "")

  let result = useQuery(
    queryOptions(
      ~queryKey="tasks",
      ~queryFn=handleFetch,
      ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(false)),
      (),
    ),
  )

  let handleSuccess = (_, _, _) => {
    setTaskName(_ => "")
    result.refetch({
      throwOnError: false,
      cancelRefetch: false,
    })
  }

  let {mutate: createTaskMutation, isLoading} = useMutation(
    mutationOptions(
      ~mutationFn=handleCreateTask,
      ~mutationKey="new-task",
      ~onSuccess=handleSuccess,
      (),
    ),
  )

  let handleCreateTask = _ => {
    createTaskMutation(. taskName, None)
  }

  let handleChange = event => {
    let target = event->ReactEvent.Form.target
    let value = target["value"]

    setTaskName(_ => value)
  }

  {
    handleChange: handleChange,
    result: switch result {
    | {isLoading: true} => Loading
    | {isError: true} => Error
    | {data: Some(Error(_))} => Error
    | {data: Some(Ok(tasks)), isLoading: false, isError: false} => Data(tasks)
    | _ => Error
    },
    taskName: taskName,
    handleCreateTask: handleCreateTask,
    isCreating: isLoading,
  }
}
