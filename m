Content-Type: multipart/mixed; boundary="===============0942391234759807194=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: connection manager interface
Date: Mon, 13 Oct 2014 11:10:57 -0500
Message-ID: <543BF991.2040200@gmail.com>
In-Reply-To: <CAOD0pek_a1-=RAkMqnEPYTAukCuTGgd3YR-J5qUb4Hn11P3mZQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0942391234759807194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ernast,

On 10/13/2014 10:51 AM, Ernast Sevo wrote:
> Hello all!
>
> I have been playing around with ofono recently and was wondering how
> ofono determined when to bring up the connection manager interface. I
> know that the interfaces supported depend on the state of the device but
> what is the state (registration status, network capabilities, etc ) at
> which it is appropriate for the connection manager interface to be up? (
> I am assuming here all hardware requirements for this interface are met
> by the modem since I know this to be true, but am simply curious about
> the external factors involved.)
>

ConnectionManager is created by the ofono_gprs atom.  This atom can be =

created either in post_sim or post_online state.

The earlier state is preferred (e.g. post_sim), but some hardware =

implementations might want to delay this until post_online for whatever =

reason.  I think the majority of oFono modem drivers initialize =

ofono_gprs in the post_sim state.

Note that the functionality of ConnectionManager will be largely =

unavailable without network registration.  So you won't be able to =

activate / deactivate contexts until you are registered to the network. =

  You can however manipulate context settings and other settings (e.g. =

in Airplane mode or without being registered to a network)

Regards,
-Denis



--===============0942391234759807194==--

