{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
-- | Common handler functions.
module Handler.Usuario where

import Import
import Database.Persist.Postgresql
import Yesod.Form.Types



formAUsuario :: AForm Handler Usuario
formAUsuario = Usuario
    <$> areq textField "Apelido:  " Nothing
    <*> areq emailField "Nome:" Nothing
    <*> areq passwordField "Senha: " Nothing
    <*> areq intField "Dono de Restaurante? Digite 1 para Sim " Nothing
  
--    where
--    estilo :: [(Text, Estilo)]
--    estilo = [("Japones", Japones), ("Mexicano", Mexicano), ("Brasileiro", Brasileiro), ("Indiano", Indiano)]
formUsuario :: Html -> MForm Handler (FormResult Usuario, Widget)
formUsuario = renderTable formAUsuario


postUsuarioR :: Handler Html
postUsuarioR = do 
    ((res,_),_) <- runFormPost formUsuario
    case res of 
        FormSuccess usuario -> do 
            _ <- runDB $ insert usuario
            redirect VeryR
        _ -> redirect HomeR

getUsuarioR :: Handler Html
getUsuarioR = do
    (widget, enctype) <- generateFormPost formUsuario
    defaultLayout
        [whamlet|
            <form method=post action=@{UsuarioR}>
                ^{widget}
                <button>Cadastrar!
            |]

        

