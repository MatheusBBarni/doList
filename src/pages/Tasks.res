open Render
open Ancestor.Default

let formatDate = value => value->Js.Date.fromString->DateFns.format("dd/MM/yy hh:mm")

module EmptyState = {
  @react.component
  let make = () => {
    <Box
      display=[xs(#flex)]
      flexDirection=[xs(#column)]
      alignItems=[xs(#center)]
      justifyContent=[xs(#center)]
      height=[xs(40.0->#rem)]>
      <Base
        tag=#img mb=[xs(3)] width=[xs(200->#px)] src=Assets.emptyState alt="Não há nenhuma task"
      />
      <Typography
        m=[xs(0)]
        mb=[xs(1)]
        tag=#h2
        textAlign=[xs(#center)]
        fontSize=[xs(2.4->#rem)]
        fontWeight=[xs(#bold)]
        letterSpacing=[xs(-0.055->#em)]
        color=[xs(Theme.Colors.white)]>
        {`Não há tarefas pendentes`->s}
      </Typography>
      <Typography
        m=[xs(0)]
        tag=#p
        textAlign=[xs(#center)]
        fontSize=[xs(1.8->#rem)]
        letterSpacing=[xs(-0.03->#em)]
        color=[xs(Theme.Colors.grayLight)]>
        {`Adicione sua primeira tarefa utilizando o campo acima`->s}
      </Typography>
    </Box>
  }
}

module ErrorMessage = {
  @react.component
  let make = () => {
    <Box
      display=[xs(#flex)]
      flexDirection=[xs(#column)]
      alignItems=[xs(#center)]
      justifyContent=[xs(#center)]
      height=[xs(40.0->#rem)]>
      <Typography
        m=[xs(0)]
        mb=[xs(1)]
        tag=#h2
        textAlign=[xs(#center)]
        fontSize=[xs(2.4->#rem)]
        fontWeight=[xs(#bold)]
        letterSpacing=[xs(-0.055->#em)]
        color=[xs(Theme.Colors.white)]>
        {`Ocorreu algo inesperado`->s}
      </Typography>
      <Typography
        m=[xs(0)]
        tag=#p
        textAlign=[xs(#center)]
        fontSize=[xs(1.8->#rem)]
        letterSpacing=[xs(-0.03->#em)]
        color=[xs(Theme.Colors.grayLight)]>
        {`Por favor, tente novamente`->s}
      </Typography>
    </Box>
  }
}

module TaskItem = {
  @react.component
  let make = (~name, ~createdAt, ~completed) => {
    <Box
      display=[xs(#flex)]
      justifyContent=[xs(#"space-between")]
      alignItems=[xs(#center)]
      mb=[xs(2)]
      px=[xs(3)]
      py=[xs(2)]
      bgColor=[xs(Theme.Colors.grayDark)]
      borderRadius=[xs(1)]>
      <Box>
        <Typography
          tag=#p
          m=[xs(0)]
          mb=[xs(1)]
          fontSize=[xs(1.6->#rem)]
          color=[xs(Theme.Colors.white)]
          letterSpacing=[xs(-0.035->#em)]>
          {name->s}
        </Typography>
        <Typography
          tag=#p
          m=[xs(0)]
          fontSize=[xs(1.4->#rem)]
          color=[xs(Theme.Colors.grayLight)]
          letterSpacing=[xs(-0.035->#em)]>
          {createdAt->s}
        </Typography>
      </Box>
      <Checkbox checked=completed />
    </Box>
  }
}

module Spinner = {
  @react.component
  let make = () => {
    <Box
      display=[xs(#flex)]
      flexDirection=[xs(#column)]
      alignItems=[xs(#center)]
      justifyContent=[xs(#center)]
      width=[xs(100.0->#pct)]
      minH=[xs(40.0->#rem)]>
      <Base tag=#img width=[xs(7.4->#rem)] src=Assets.spinner />
    </Box>
  }
}

module TaskInput = {
  @react.component
  let make = (~onChange, ~taskName, ~onSubmit, ~isLoading) => {
    <Box>
      <Typography
        tag=#label
        m=[xs(0)]
        fontWeight=[xs(#bold)]
        fontSize=[xs(2.4->#rem)]
        lineHeight=[xs(3.1->#rem)]
        color=[xs(Theme.Colors.white)]
        letterSpacing=[xs(-0.035->#em)]>
        {`Nova Tarefa`->s}
      </Typography>
      <Box mt=[xs(2)] position=[xs(#relative)]>
        <Input value=taskName onChange placeholder="Compras da semana" />
        <Box position=[xs(#absolute)] right=[xs(9->#px)] top=[xs(9->#px)]>
          <Button onClick=onSubmit disabled={taskName === "" || isLoading} loading=isLoading>
            {`Adicionar`}
          </Button>
        </Box>
      </Box>
    </Box>
  }
}

@react.component
let make = () => {
  let {result, handleChange, handleCreateTask, taskName, isCreating} = TasksHook.useTasks()

  <Box display=[xs(#flex)] alignItems=[xs(#center)] flexDirection=[xs(#column)]>
    <Box display=[xs(#flex)] justifyContent=[xs(#center)] tag=#header>
      <img src=Assets.logo alt="Todo List App logo" />
    </Box>
    <Box
      mt=[xs(10)]
      width=[xs(100.0->#pct)]
      maxW=[xs(63.4->#rem)]
      display=[xs(#flex)]
      flexDirection=[xs(#column)]>
      <TaskInput onChange=handleChange onSubmit=handleCreateTask taskName isLoading=isCreating />
      <Box mt=[xs(4)]>
        {switch result {
        | Loading => <Spinner />
        | Error => <ErrorMessage />
        | Data([]) => <EmptyState />
        | Data(tasks) =>
          tasks->map(({name, completed, createdAt}, key) => {
            <TaskItem key name completed createdAt={createdAt->formatDate} />
          })
        }}
      </Box>
    </Box>
  </Box>
}
