import os
import parsing as p
import triage as t
import display as d


CompleteList = t.triage("new_new_analysis_nf")
nb_graph = 0

#print(CompleteList)
for y in CompleteList:
      
    id_sommet = p.new_new_Parsing(y)[0]
        #print(id_sommet)
    partenaire = p.new_new_Parsing(y)[1]
        #print(partenaire)


        #print(partenaire)
    d.Affichage(id_sommet, partenaire, nb_graph)
    nb_graph += 1
            