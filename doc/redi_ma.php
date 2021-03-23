<?php

/*
 *    Endote Volltext Suchhilfe
 *
 *    Andreas Bohne-Lang, 2011
 *
 *    Das Skript muss auf einem Rechner im Netz der Einrichtung laufen.
 *
 */

// hier editieren:
$redi_url="http://www.redi-bw.de/links/unihdma"; // Redi-Resolver mit Account
#$proxy="proxy.medma.uni-heidelberg.de:8080"; // Web-Proxy, falls benoetigt
$take_last=true;   // bei mehr als einem Link und kein "besserer", nimm den letzten

#------------------------------------------------------

if( isset($proxy) && !empty($proxy) ){
        $opts = array("http" => array("proxy" => "tcp://$proxy", "request_fulluri" => true, "user_agent"=>"Endnote"));
} else {
        $opts = array("http" => array("request_fulluri" => false, "user_agent"=>"Endnote" ));
}

$context = stream_context_create($opts);
$nurl	= "";
$qs 	= preg_replace('/[\n\r]/','',$_SERVER["QUERY_STRING"]);
$qs 	= str_replace(chr(0), '', $qs);
$turl 	= sprintf("%s?%s",$redi_url,$qs);



$doc 	= new DOMDocument();
$doc->loadXML(file_get_contents($turl,false,$context));

$xpath 	= new DOMXPath($doc);
$xpath->registerNamespace("ezb", "http://www.w3.org/1999/xhtml");
$nodes 	= $xpath->query('//ezb:div[@class="t_ezb_result"]//ezb:span[@class="t_link"]/ezb:a/attribute::href');

$xurl=array();
for($i=0; $i < $nodes->length; $i++){
        $txurl= $nodes->item($i)->nodeValue;
        $xurl[$i]=$txurl;
        $theader=get_headers($txurl);
        $xset=false;
        foreach($theader as $thval){
                if(substr($thval,0,strlen("Location:")) == "Location:"){
                        if( $xset == false){
                                $xurl[$i]=trim(substr($thval,strlen("Location:")));
                                $xset=true;
                        }
                }
        }
}

$location="";

if($nodes->length>=1){
        if ( $take_last) {               
                $location=$xurl[$nodes->length-1];
        } else {
                $location=$xurl[0];
        }
} else{
        
        $location= $turl;

        # http://www.ub.uni-heidelberg.de/cgi-bin/edok?dok=
        if(strstr($location,"http://www.ub.uni-heidelberg.de/cgi-bin/edok?dok=")){
                $location=urldecode(substr(strstr($location,"dok="),4));
        }

        # http://ezb.uni-regensburg.de/ezeit/warpto.phtml?bibid=UBHE&color=2&jour_id=1402&url=http%3A%2F%2Fdx.doi.org%2F10.1109%2FTBME.2005.862571
        if(strstr($location,"http://ezb.uni-regensburg.de/ezeit/warpto.phtml")){
                $location=urldecode(substr(strstr($location,"url="),4));
        }

}
$location=sprintf("https://www.umm.uni-heidelberg.de/ezproxy/login.auth?url=%s",urlencode($location));

header(sprintf("Location: %s\n\r",$location)); die;
?>
