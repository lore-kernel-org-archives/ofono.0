Content-Type: multipart/mixed; boundary="===============3374840220164156224=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Wed, 05 Jan 2011 16:12:01 -0800
Message-ID: <1294272721.2521.34.camel@aeonflux>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9C123E86@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3374840220164156224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,

> gprs: add function to handle activated context
> ofono_gprs_context_activated : this function is symetric to ofono_gprs_co=
ntext_deactivated.
> This function must be call by any gprs-context driver when a context has =
been activated without explicit request.
> =

> Behavior of the function :
> =

> List all the context and try to find correct APN

we have to be careful to only match against APN=3D=3DAPN and Username=3D=3D=
"" +
Password=3D=3D"".

The username and password option is pretty much pointless, but it is
present and we do support it. So we need to make sure the APN matching
sensible. Or does the network provide us with additional information
about the username + password as well?

> If such context is not found create a new one with "Internet" type.

I don't really agree that we should create a context if no match is
found. I think the better sensible strategy is to hold this information
internally and only map it to a context once the user or provisioning
creates it.

Also oFono will create at least one Internet context automatically. And
in the future that might be auto-provisioned.

Another option would be to introduce the concept of temporary context
where the lifetime is mandated by the network.

> For the context (found or created):
> 	Update the settings
> 	Set to active

Regards

Marcel



--===============3374840220164156224==--

