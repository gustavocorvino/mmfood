{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
-- | Common handler functions.
module Handler.Restaurante where

import Import
import Database.Persist.Postgresql
import Yesod.Form.Types


getRestauranteR :: Handler Html
getRestauranteR = do 
    (widget,enctype) <- generateFormPost formRestaurante
    defaultLayout $ do
        [whamlet|
            <form action=@{RestauranteR} method=post>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]
        
data Estilo = Japones | Mexicano | Brasileiro | Indiano
   deriving (Show, Eq, Enum, Bounded)


formARestaurante :: AForm Handler Restaurante
formARestaurante = Restaurante
    <$> areq textField "Nome: " Nothing
    <*> areq emailField "Dono:" Nothing
    <*> areq textField "Endereço: " Nothing
    <*> areq textField "Estilo: " Nothing
    <*> areq textField "Abertura: " Nothing
    <*> areq textField "Fechamento: " Nothing
--    where
--    estilo :: [(Text, Estilo)]
--    estilo = [("Japones", Japones), ("Mexicano", Mexicano), ("Brasileiro", Brasileiro), ("Indiano", Indiano)]

formRestaurante :: Html -> MForm Handler (FormResult Restaurante, Widget)
formRestaurante = renderTable formARestaurante
    
postRestauranteR :: Handler Html
postRestauranteR = do 
    ((res,_),_) <- runFormPost formRestaurante
    case res of 
        FormSuccess restaurante -> do 
            _ <- runDB $ insert restaurante
            redirect VeryR
        _ -> redirect HomeR