#' Plot two PANDA networsk in Cytoscape
#'
#'This function is able to modify PANDA network and plot in Cytoscape.
#'
#' @param merged_panda vector indicating the merged PANDA networks in data frame structure type.
#' @param condition_name string vector indicating the same condition name used in \code{\link{panda.diff.edges}}. 
#' @param network_name Character string indicating the name of Cytoscape network.
#' @examples
#' \dontrun{
#' # run this function to create a network in Cytoscape.
#' merged.panda <- vis.diff.panda.in.cytoscape(panda.net1, panda.net1, network.name="diff.PANDA")
#' # then plot two PANDA network in Cytoscape.
#' vis.diff.panda.in.cytoscape(merged.panda,condition_name = "cond.1", network_name="diff.PANDA" )
#' }
#' @return NULL
#' 
#' @import RCy3
#' @export 
#' 

vis.diff.panda.in.cytoscape <- function(merged_panda, condition_name = "cond.1", network_name="diff.PANDA"){
# plot 
# launch Cytoscape 3.6.1 or greater
cytoscapePing ()
cytoscapeVersionInfo ()

colnames(merged_panda) <- c("source","target","motif","weight",condition_name)
merged_panda$weight_transformed <- rank(merged_panda$weight)/length(merged_panda$weight)*10000
if(nrow(merged_panda)>6666){
  message("The maximum network objects (nodes+edges) that Cytoscape could support varies in different memories.
          0-20000 objects are suggested by 512M memory size for Cytoscape to view. 
          For better view function in Cytoscape please reduce the size of PANDA network imported")
}
#create nodes arg for creating a cytoscape plot
panda_nodes <- data.frame(id=c(merged_panda$source,merged_panda$target), group=rep(c("TF","Gene"), each=nrow(merged_panda)),stringsAsFactors=FALSE)
# creat cytoscape from DataFrames
createNetworkFromDataFrames(nodes=panda_nodes,edges=merged_panda, title=network_name, collection="DataFrame Example")

}

