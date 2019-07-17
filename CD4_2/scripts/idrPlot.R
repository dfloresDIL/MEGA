# Run it with Rscript --vanilla
library(ggplot2)

args = commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
  stop("I need an idr txt input file and a pdf output file", call.=FALSE)
}

fileName  <- args[1]
condition  <- gsub(".txt$","",basename(fileName))

data.df <- read.csv(fileName,sep="\t",header=FALSE)
colnames(data.df) <- c("chrom","chromStart","chromEnd","name","score","strand","signalValue",
                       "P-val","Q-val","summit","localIDR","globalIDR","rep1_chromStart",
                       "rep1_chromEnd","rep1_signalValue","rep1_summit","rep2_chromStart",
                       "rep2_chromEnd","rep2_signalValue","rep2_summit")

idr <- sort(10^-data.df$globalIDR)
peaks.df <- data.frame(Peaks=seq(1:length(idr)),IDR=idr)

png(args[2])
ggplot(peaks.df,aes(x=Peaks,y=IDR)) +
    geom_line(size=2,lineend = "round",alpha=0.75) +
    geom_hline(yintercept = 0.05,linetype="dashed",alpha=0.45) + # IDR = 0.05
    geom_vline(xintercept = 20000,linetype="dotted") + # ngenes human genome
    geom_text(aes(x=20100, label="Genes in hg", y=-.02),colour="grey") +
    geom_text(aes(x=200, label="IDR=0.05", y=.06),colour="grey") +
    coord_cartesian(xlim = c(0, 40000),ylim = c(0, 0.6)) +
    ggtitle(condition)
dev.off()

# END
