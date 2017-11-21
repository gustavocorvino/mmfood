{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}
module Handler.Home where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        addStylesheet $ (StaticR css_home_css)
        [whamlet|
              <body>
                <center><h1>Sushifinder &#x1f363
                <center><h2>O quer quer fazer hoje?
                 <form action=@{RecomendarR} method=GET>
                                    <input type="submit" value="Dar Notas">
                 <form action=@{RecomendarR} method=GET>
                                    <input type="submit" value="Procurar um restaurante">
                                    
                         |]


