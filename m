Content-Type: multipart/mixed; boundary="===============4754840464781969509=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 13:27:48 -0500
Message-ID: <201004071327.48885.denkenz@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C141100E@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4754840464781969509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> =

> Currently the modem driver acknowledges the PDU right away. If there was a
>  notification back to the modem driver, the PDU acknowledgement could be
>  delayed till that point in time. If something bad happens in between,
>  either the modem or the network can hold on to the PDU and redeliver once
>  oFono is up and running again.
> =

> Looking at at_cmt_notify() the current implementation might have that
>  affect already, as AT+CNMA is only send after calling
>  ofono_sms_deliver_notify(). So as long as ofono_sms_deliver_notify() is
>  handled synchronously and ensures that the PDU is stored one way or
>  another before returning, it will work in case of a crash. (Would like to
>  see assumptions like that called out in the code) That said, if your
>  storage has issues (disk full?) there is currently no way to let the mod=
em
>  driver know that delivery was unsuccessful.

You described the current implementation perfectly.  The driver can assume =

that the fragment has been stored after the call to sms_deliver_notify has =

returned.  For its part, the history plugin should ensure the storage is =

synced when any of the callbacks are called.

I freely admit the lack of documentation, and if this is a comment you want=
 to =

add in the driver definition file I would gladly accept it.  However, up to=
 this =

point we've only had a single driver for SMS and it gets this part right.

The disk full case we're aware of.  Again, this can easily be avoided or =

minimized by notifying the user of such conditions in advance.  This was an =

important use case for devices with 512K of storage, much less so for devic=
es =

with 64GB of storage.

Regards,
-Denis

--===============4754840464781969509==--

