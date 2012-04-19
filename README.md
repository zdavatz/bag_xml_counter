bag_xml_counter
===============

Counting Limitations Texts in BAG XML from http://galinfo.net

## run like this

  $ ruby ./counter_rexml.rb XMLPublications.zip

## The output will look like this:

  "preparations [de]: 927"
  "preparations [fr]: 927"
  "packs [de]: 23"
  "packs [fr]: 23"
  "itcodes [de]: 727"
  "itcodes [fr]: 727"

## Explanation

  * preparations [de]: counts the Limitation-Texts in German (same is done for fr).

  * packs [de]: counts the Limitations Packs-Tags that contian Limitations. One Tag can have many Packages.

  <Packs>
      <Pack Pharmacode="4047702" PackId="23162" ProductKey="1108941">
        <DescriptionDe>10 Stk</DescriptionDe>
        <DescriptionFr>10 pce</DescriptionFr>
        <DescriptionIt>10 pce</DescriptionIt>
        <SwissmedicCategory>C</SwissmedicCategory>
        <SwissmedicNo8>52402027</SwissmedicNo8>
        <FlagNarcosis>N</FlagNarcosis>
        <FlagModal>N</FlagModal>
        <BagDossierNo>16395</BagDossierNo>
        <Limitations />
        <PointLimitations />
        <Prices>

  * itcodes [de]: counts the IT-Codes
