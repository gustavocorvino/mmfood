{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
-- | Common handler functions.
module Handler.Login where

import Import
import Database.Persist.Postgresql
import Yesod.Form.Types


formLogin :: AForm (Text, Text) 
formLogin = renderDivs $ (,)
    <$> areq emailField "Email: " Nothing
    <*> areq passwordField "Senha: " Nothing

autenticar :: Text -> Text -> HandlerT App IO (Maybe (Entity Usuario))
autenticar email senha = runDB $ selectFirst [UsuarioEmail ==. email
                                             ,UsuarioSenha ==. senha] []
    
getLoginXR :: Handler Html
getLoginXR = do 
    (widget,enctype) <- generateFormPost formLogin
    msg <- getMessage
    defaultLayout $ do 
        [whamlet|
            $maybe mensa <- msg 
                <h1> Usuario Invalido
            <form action=@{LoginR} method=post>
                ^{widget}
                <input type="submit" value="Login">  
        |]

postLoginXR :: Handler Html
postLoginXR = do
    ((res,_),_) <- runFormPost formLogin
    case res of 
        FormSuccess ("root@root.com","root") -> do 
            setSession "_ID" "admin"
            redirect AdminR
        FormSuccess (email,senha) -> do 
            usuario <- autenticar email senha 
            case usuario of 
                Nothing -> do 
                    setMessage $ [shamlet| Usuario ou senha invalido |]
                    redirect LoginR 
                Just (Entity usrid usuario) -> do 
                    setSession "_ID" (usuarioNome usuario)
                    redirect HomeR
        _ -> redirect HomeR
                

postLogoutXR :: Handler Html
postLogoutXR = do 
    deleteSession "_ID"
    redirect HomeR