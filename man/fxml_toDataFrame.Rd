% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flatxml.r
\name{fxml_toDataFrame}
\alias{fxml_toDataFrame}
\title{Extracting data from an XML document into a dataframe}
\usage{
fxml_toDataFrame(xmlflat.df, siblings.of, same.tag = TRUE, attr.only = NULL,
  attr.not = NULL, elem.or.attr = "elem", col.attr = "",
  include.fields = NULL, exclude.fields = NULL)
}
\arguments{
\item{xmlflat.df}{A flat XML dataframe created with \code{\link{fxml_importXMLFlat}}.}

\item{siblings.of}{ID of one of the XML elements that contain the data records. All data records need to be on the same hierarchical level as the XML element with this ID.}

\item{same.tag}{If \code{TRUE}, only elements of the same type (\code{xmlflat.df$elem.}) as the element \code{sibling.of} are considered as data records. If \code{FALSE},
\emph{all} elements on the same hierarchical level as the element \code{sibling.of} are considered to be data records.}

\item{attr.only}{A list of named vectors representing attribute/value combinations the data records must match.
The name of an element in the list is the XML element name to which the attribute belongs. The list element itself is a named vector.
The vector's elements represent different attributes (= the names of the vector elements) and their values (= vector elements).
Example: \code{attr.only = list(tag1 = c(attrib1 = "Value 1", attrib2 = "Value 2"), tag2 = c(attrib3 = "Value 3"))} will only include \code{tag1} elements of the form \code{<tag1 attrib1 = "Value 1" attrib2 = "Value 2">} and \code{tag2} elements of the form \code{<tag2 attrib3 = "Value 3">} as data records.}

\item{attr.not}{A list of vectors representing attribute/value combinations the XML elements must \emph{not} match to be considered as data records. See argument \code{attr.only} for details.}

\item{elem.or.attr}{Either \code{"elem"} or \code{"attr"}. Defines, if the names of the record fields (columns in the dataframe) are represented by the names (tags) of the respective XML elements
(the children of the elements on the same level as \code{siblings.of}) (\code{"elem"}) or if the field names are given by some attribute of those tags (\code{"attr"}).}

\item{col.attr}{If \code{elem.or.attr} is \code{"attr"} then \code{col.attr} specifies the name of the attribute that gives the record field / column names.}

\item{include.fields}{A character vector with the names of the fields that are to be included in the result dataframe. By default, all fields from the XML document are included.}

\item{exclude.fields}{A character vector with the names of the fields that should be excluded in the result dataframe. By default, no fields from the XML document are excluded.}
}
\value{
A dataframe with the data read in from the XML document.
}
\description{
Reads in data from an XML document and returns a dataframe.
}
\details{
Data that can be read in are either represented in this way:\cr \cr
  \code{<record>}\cr
    \code{<field1>Value of field1</field1>}\cr
    \code{<field2>Value of field2</field2>}\cr
    \code{<field3>Value of field3</field3>}\cr
  \code{</record>}\cr
  \code{...}\cr \cr
In this case \code{elem.or.attr} would need to be \code{"elem"} because the field names of the data records (\code{field1}, \code{field2}, \code{field3}) are the names of the elements.\cr \cr
Or, the XML data could also look like this: \cr \cr
  \code{<record>}\cr
    \code{<column name="field1">Value of field1</column>}\cr
    \code{<column name="field2">Value of field2</column>}\cr
    \code{<column name="field3">Value of field3</column>}\cr
  \code{</record>}\cr
  \code{...}\cr \cr
Here, the names of the fields are attributes, so \code{elem.or.attr} would need to be \code{"attr"} and \code{col.attr} would be set to
\code{"name"}, so \code{fxml_toDataframe()} knows where to look for the field/column names.\cr \cr
In any case, \code{siblings.of} would be the ID (\code{xmlflat.df$elemid.}) of one of the \code{<record>} elements.
}
\examples{
# Load example file with population data from United Nations Statistics Division
# and create flat dataframe
example <- system.file("worldpopulation.xml", package="flatxml")
xml.dataframe <- fxml_importXMLFlat(example)

# Extract the data out of the XML document. The data records are on the same hierarchical level
# as element with ID 3 (xml.dataframe$elemid. ==  3).
# The field names are given in the "name" attribute of the children elements of element no. 3
# and its siblings
population.df <- fxml_toDataFrame(xml.dataframe, siblings.of=3, elem.or.attr="attr",
col.attr="name")
# Exclude the "Value Footnote" field from the returned dataframe
population.df <- fxml_toDataFrame(xml.dataframe, siblings.of=3, elem.or.attr="attr",
col.attr="name", exclude.fields=c("Value Footnote"))


# Load example file with soccer world cup data (data from
# https://www.fifa.com/fifa-tournaments/statistics-and-records/worldcup/index.html)
# and create flat dataframe
example2 <- system.file("soccer.xml", package="flatxml")
xml.dataframe2 <- fxml_importXMLFlat(example2)

# Extract the data out of the XML document. The data records are on the same hierarchical level
# as element with ID 3 (xml.dataframe$elemid. ==  3). #' # The field names are given as the name
# of the children elements of element no. 3 and its siblings.
worldcups.df <- fxml_toDataFrame(xml.dataframe2, siblings.of=3, elem.or.attr="elem")
}
\seealso{
\code{\link{fxml_importXMLFlat}}
}
\author{
Joachim Zuckarelli \email{joachim@zuckarelli.de}
}
