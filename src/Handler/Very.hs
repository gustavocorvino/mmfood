{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies, DeriveGeneric #-}
module Handler.Very where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getVeryR :: Handler Html
getVeryR = do
    defaultLayout $ do
        addStylesheet $ (StaticR css_home_css)
        [whamlet|
              <body>
              <h1><a href="https://www.youtube.com/watch?v=ptlsnR7V_-Y&t=19s">G A L O D E K A L S A</a>
        |]