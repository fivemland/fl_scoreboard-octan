<script>
  import { visible, Users, serverInfos } from "./store";
  import { scale } from "svelte/transition";

  let usersList;

  window.addEventListener("message", ({ data }) => {
    if (data.scrollY !== undefined && usersList) {
      const max = usersList.scrollHeight - usersList.clientHeight;
      if (data.scrollY > max) {
        fetch(`https://${GetParentResourceName()}/setMaxScroll`, {
          method: "POST",
          body: JSON.stringify({ max }),
        });
      }

      usersList.scrollTo(0, data.scrollY);
    }
  });

  $: percentage = Math.floor(
    ($serverInfos.Players / $serverInfos.MaxClients) * 100
  ).toString();

  function toMinute(time) {
    time = new Date(time);
    const timeDiff = new Date(Date.now() - time);
    return timeDiff.getMinutes();
  }
</script>

<svelte:head>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
  />
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
    integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
    crossorigin="anonymous"
    referrerpolicy="no-referrer"
  />
</svelte:head>

{#if $visible}
  <!-- {$scrollYCoord} -->
  <div
    class="w-[35%] bg-black/40 h-1/2 flex flex-col gap-2 border-4 border-black/40 text-white"
    in:scale
    out:scale
  >
    <div
      class="w-full h-[10%] flex items-center justify-between bg-black/30 py-5 px-2"
    >
      <div class="h-full flex items-center">
        <img class="h-[3vh]" src={$serverInfos.Logo} alt="logo" />
      </div>
      <div
        class="bg-black/50 py-[1.6vh] px-[0.05vw] flex  h-full w-1/5 items-center relative"
      >
        <div
          class="relative h-[3vh] bg-[#466a1c]"
          style="width: {percentage}%"
        />
        <div class="absolute left-[50%] translate-x-[-50%] ">
          {$serverInfos.Players}/{$serverInfos.MaxClients}
        </div>
      </div>
    </div>
    <div
      class="overflow-y-auto w-full h-full flex flex-col gap-1 px-3"
      bind:this={usersList}
    >
      {#if $Users.length == 0}
        <div class="w-full h-full flex justify-center items-center">
          Nincsen elérhető játékos!
        </div>
      {/if}
      {#each $Users as User}
        <div
          class="w-full flex justify-between  p-1 border-b-[1px] border-black/20 "
        >
          <div class="w-1/3 flex items-center justify-start">
            {User.playerId}
          </div>
          <div class="w-1/3 flex items-center justify-center">
            {User.name}
          </div>
          <div class="w-1/3 flex items-center justify-end">
            {toMinute(User.joinTime)} perce online
          </div>
        </div>
      {/each}
    </div>
  </div>
{/if}
