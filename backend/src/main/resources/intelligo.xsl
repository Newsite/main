<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    
    exclude-result-prefixes="oai_dc dc">
    
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>
    
    <xsl:param name="solr_id" />
    
    <xsl:param name="ab_es" />
    <xsl:param name="ab_en" />
    <xsl:param name="ab_pt" />
    
    <xsl:param name="ti_es" />
    <xsl:param name="ti_en" />
    <xsl:param name="ti_pt" />
	
	 
    <xsl:template match="oai_dc:dc">
            <doc>
                <!-- ID es parámetro -->
                <field name="id">
                	<xsl:value-of select="$solr_id"/>
                </field>
                
                 <!-- URL -->
				<xsl:for-each select="//dc:identifier">
					<xsl:choose>
						<xsl:when test="starts-with(., 'http://')">
							<field name="url">
								<xsl:value-of select="." />
							</field>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
                 
                
                <!-- LANGUAGE -->
                <xsl:if test="//dc:language">
                    <xsl:for-each select="//dc:language">
                        <xsl:if test="string-length() > 0">
							<field name="language">
                                    <xsl:value-of select="normalize-space()"/>
                            </field>
					    </xsl:if>
                    </xsl:for-each>
                </xsl:if>

              
                <!-- AUTHOR -->
                <xsl:if test="//dc:creator">
                    <xsl:for-each select="//dc:creator">
                        <xsl:if test="normalize-space()">
                                <field name="author">
                                    <xsl:value-of select="normalize-space()"/>
                                </field>
                        </xsl:if>        
                    </xsl:for-each>
                </xsl:if>
                
                 <!-- AUTHOR2 - Contributor -->
                <xsl:if test="//dc:contributor">
                    <xsl:for-each select="//dc:contributor">
                                <field name="contributor">
                                    <xsl:value-of select="normalize-space()"/>
                                </field>
                    </xsl:for-each>
                </xsl:if>
                

                <!-- TITLE -->
                <xsl:if test="//dc:title[normalize-space()]">
                    <field name="title">
                        <xsl:value-of select="//dc:title[normalize-space()]"/>
                    </field>
                </xsl:if>

                <!-- PUBLISHER -->
                <xsl:if test="//dc:publisher[normalize-space()]">
                    <field name="publisher">
                        <xsl:value-of select="//dc:publisher[normalize-space()]"/>
                    </field>
                </xsl:if>

                <!-- SUBJECT -->
                <xsl:if test="//dc:subject">
                    <xsl:for-each select="//dc:subject">
                        <xsl:if test="string-length(normalize-space()) > 0">
                            <field name="topic">
                                <xsl:value-of select="normalize-space()"/>
                            </field>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:if>

                <!-- DESCRIPTION 
                <xsl:if test="//dc:description">
                    <field name="description">
                        <xsl:value-of select="//dc:description" />
                    </field>
                </xsl:if>
				-->
				
                <!-- PUBLISHDATE -->
                <xsl:if test="//dc:date">
                    <field name="year">
                        <xsl:value-of select="substring(//dc:date, 1, 4)"/>
                    </field>
              
                </xsl:if>
                
                 <!-- rights -->
               <xsl:for-each select="//dc:rights">
            
              		<field name="rights">
						<xsl:value-of select="." />
					</field>
		   
               </xsl:for-each>

				 <!-- ab -->
                <field name="ab_es">
                	<xsl:value-of select="$ab_es"/>
                </field>	
				<field name="ab_en">
                	<xsl:value-of select="$ab_en"/>
                </field>	
				<field name="ab_pt">
                	<xsl:value-of select="$ab_pt"/>
                </field>
                
                <!-- ti -->
                <field name="ti_es">
                	<xsl:value-of select="$ti_es"/>
                </field>	
				<field name="ti_en">
                	<xsl:value-of select="$ti_en"/>
                </field>	
				<field name="ti_pt">
                	<xsl:value-of select="$ti_pt"/>
                </field>		
               
            </doc>
    </xsl:template>
</xsl:stylesheet>
