const recipebtn=document.getElementById("recipebtn")
const recipesearch=document.getElementById("recipesearch")

recipebtn.addEventListener("click",()=>{

    let s=recipesearch.value

    let query=new FormData()

    query.append("query",s)


    console.log(query.get("query"))



    fetch("http://localhost/search/blog",{
        method:"POST",
        body:query
    })
    .then(r=>r.json())
    .then(r=>{
        const items=r.items
        for(let i = 0 ; i<items.length;i++){
            let item=r.items[i]
            console.log(item.link)
            console.log(item.title)
        }
    })
})