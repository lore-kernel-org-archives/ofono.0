Content-Type: multipart/mixed; boundary="===============8248101846638097169=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] hfp: set timeout to service level connection procedure
Date: Fri, 12 Feb 2010 15:46:30 -0600
Message-ID: <201002121546.30481.denkenz@gmail.com>
In-Reply-To: <1265928762-24090-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8248101846638097169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> If it expires we call org.bluez.HandsfreeGateway.Disconnect()
> It also modifies send_method_call and break it down into two functions.
> Now we have send_method_call_with_reply, for DBus messages that needs a
> reply. It sets a reply and a timeout for the message reply.
> The other funcion is called send_method_call without timeout or reply
> parameters.

Patch has been applied, thanks.

Regards,
-Denis

--===============8248101846638097169==--

