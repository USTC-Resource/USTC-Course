#include <stdlib.h>
#include <string.h>

#include "SyntaxTree.h"

SyntaxTreeNode * newSyntaxTreeNodeNoName()
{
	return newSyntaxTreeNode(NULL);
}

SyntaxTreeNode * newSyntaxTreeNode(const char * name)
{
	SyntaxTreeNode * newNode = (SyntaxTreeNode *)malloc(sizeof(SyntaxTreeNode));
	if (name)
		strcpy(newNode->name, name);
	else
		newNode->name[0] = '\0';
	newNode->children_num = 0;
	return newNode;
}

SyntaxTreeNode * newSyntaxTreeNodeFromNum(const int num)
{
	SyntaxTreeNode * newNode = newSyntaxTreeNodeNoName();
	sprintf(newNode->name, "%d", num);
	newNode->children_num = 0;
	return newNode;
}

int SyntaxTreeNode_AddChild(SyntaxTreeNode * parent, SyntaxTreeNode * child)
{
	if (!parent || !child)	return -1;
	parent->children[parent->children_num++] = child;
	return parent->children_num;
}

void deleteSyntaxTreeNodeNoRecur(SyntaxTreeNode * node)
{
	deleteSyntaxTreeNode(node, 0);
}

void deleteSyntaxTreeNode(SyntaxTreeNode * node, int recursive)
{
	if (!node)	return;

	int i;
	if (recursive) {
		for (i = 0; i < node->children_num; i++) {
			deleteSyntaxTreeNode(node->children[i], 1);
		}
	}
	free(node);
}

SyntaxTree * newSyntaxTree()
{
	return (SyntaxTree *)malloc(sizeof(SyntaxTree));
}

void deleteSyntaxTree(SyntaxTree * tree)
{
	if (!tree)	return;

	if (tree->root) {
		deleteSyntaxTreeNode(tree->root, 1);
	}
	free(tree);
}

void printSyntaxTreeNode(FILE * fout, SyntaxTreeNode * node, int level)
{
	// assume fout valid now
	
	// check if "node" empty pointer
	if (!node)	return;
	
	// print myself
	int i;
	for (i = 0; i < level; i++) {
		fprintf(fout, "|  ");
	}
	fprintf(fout, ">--%s %s\n", (node->children_num ? "+" : "*"), node->name);

	for (i = 0; i < node->children_num; i++) {
		printSyntaxTreeNode(fout, node->children[i], level + 1);
	}
}

void printSyntaxTreeNodeGraphic(FILE* fout, SyntaxTreeNode* node)
{
	fprintf(fout, "svgling.draw_tree(");
	printSyntaxTreeNodeGraphic1(fout, node);
	fprintf(fout, ")\n");
}

void printSyntaxTreeNodeGraphic1(FILE* fout, SyntaxTreeNode* node)
{
	if (!node) return;
	int i;
	fprintf(fout, "(\"%s\"", node->name);
	for (i = 0; i < node->children_num; i++) {
		fprintf(fout, ", ");
		printSyntaxTreeNodeGraphic1(fout, node->children[i]);
	}
	fprintf(fout, ")");
}

void printSyntaxTree(FILE * fout, SyntaxTree * tree)
{
	if (!fout)	return;
	
	printSyntaxTreeNode(fout, tree->root, 0);
}

