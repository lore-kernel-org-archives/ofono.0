Content-Type: multipart/mixed; boundary="===============8152126958566504376=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] hfp_hf_bluez5: Handle org.bluez.Profile1.Release()
Date: Tue, 20 Aug 2013 10:41:45 -0500
Message-ID: <52138E39.6030705@gmail.com>
In-Reply-To: <CABBYNZK4XhtKnM2nyZ7jFkjVQ1Bi_nVB=DxOeN7GMrq-CX9VSA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8152126958566504376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

 >> I agree. Going to fix, and send a patch to BlueZ to add that label.
>
> While at it you might consider actually handling the Release because
> right now oFono doesn't react to either org.bluez disappearing nor
> adapter proxy being removed so if one of those events happen without
> calling RequestDisconnection oFono will keep the connection.
>

As long as BlueZ calls shutdown() on the socket, the resources will be =

cleaned up by the oFono HUP handler.

> Before anyone asks, there is another difference between Release and
> RequestDisconnection, the former should cause a forceful disconnect if
> connected while the latter should disconnect gracefully so bluetoothd
> will wait for the response so in theory Release can happen without
> RequestDisconnection being called before.
>

The only time BlueZ calls Release() today is when gracefully shutting =

down.  It calls shutdown() then anyway.

It might be argued that we should shut down the SCO server socket if =

BlueZ has called Release() on our profile.  Looking at the code, it =

looks like we only accept SCO connections when a given =

handsfree_audio_card matches a connection request.  So assuming the =

kernel has SCO defer setup handling, we should be okay with the current =

behavior.  Comments?

Regards,
-Denis


--===============8152126958566504376==--

