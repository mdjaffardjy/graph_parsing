import os
import parsing as p
import triage as t
import display as d


CompleteList = t.triage("new_new_analysis_nf")
nb_graph = 0


for y in CompleteList:
    
    
    if nb_graph < 7 : ## a enlever plus tard juste pour les test
        
        print(y)  

        res =  p.new_new_Parsing(y)
        id_sommet = res[0]
        
        partenaire = res[1]

        d.Affichage(id_sommet, partenaire, nb_graph)
        nb_graph += 1
            
        