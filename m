Content-Type: multipart/mixed; boundary="===============3273846332310802395=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Reg: Memory capacity exceeded
Date: Mon, 20 Sep 2010 14:09:35 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A519AF@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1284980219.20811.32.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3273846332310802395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
 =

> If  device memory capacity is over there is a way to set HLR about =

> memory capacity exceeded.
> But in Ofono I didn't find any indication regarding memory capacity =

> exceeded for class 1 messages.
> =

> Is this feature is going to be added in future? please let me know.

> when you reached that state with oFono, then you have different
problems ;)

> oFono is not using the SIM storage at all. Everything happens on the
host storage.

I think Rams question applies to both ME and SIM storage. =


Class 2 Messages are stored in the SIM whereas Class 1 Messages are
stored in the device storage which can be host storage or SIM storage.

When the storage is full, then the ME can inform the network that the
memory capacity is full. This is to make sure network is not forwarding
the messages to =

ME. =


When the storage is available, then the ME can inform the network that
it has space for receiving messages.

Incase of SIM storage, there is a SIM file which has the memory capacity
exceeded flag information.

Regards,
jeevaka=20

--===============3273846332310802395==--

