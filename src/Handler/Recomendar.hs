{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}

module Handler.Recomendar where


import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getRecomendarR :: Handler Html
getRecomendarR = do
    defaultLayout $ do
        addStylesheet $ (StaticR css_home_css)
        [whamlet|
              <body>
                <center><h1>Sushifinder &#x1f363
                <center><h2>O quer quer fazer hoje?
                         |]