Content-Type: multipart/mixed; boundary="===============1303078602540458333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono DUN server issue
Date: Thu, 14 Jun 2012 17:29:44 -0500
Message-ID: <4FDA65D8.3020608@gmail.com>
In-Reply-To: <20120615022711.GA3538@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1303078602540458333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

>> Likely the culprit is this line inside __dundee_bluetooth_init
>>
>>          err =3D bluetooth_register_uuid(DUN_GW_UUID,&dun_profile);
>>
>> It should probably use the UUID of the DUN client, not the gateway.
>
> We actually don't have an client uuid for DUN, and we need to put the ser=
ver
> uuid here in order to find the remote DUN Gateways.
> Other than that he reported an issue in oFono, so how can dundee interfer=
e on
> it?

I'm just speculating, but the problem here is that both dundee and the =

modem emulator are registering the DUN service.  Unfortunately dundee is =

implementing the client role and modem emulator is implementing the =

server role.

Perhaps dundee does not need to register an SDP record at all.  I'm too =

lazy to dig out the DUN spec.

Regards,
-Denis

--===============1303078602540458333==--

