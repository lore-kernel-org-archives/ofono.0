Content-Type: multipart/mixed; boundary="===============1930025470506306640=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Reg: Memory capacity exceeded
Date: Mon, 20 Sep 2010 17:08:41 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A51A03@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <4C97573D.90406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1930025470506306640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Denis,

> The thing is, oFono configures SMS for direct delivery (e.g. no SM/ME
storage).  And even if direct delivery does not work (e.g. crappy modem
or Class 2 / Class 3 messages) oFono still removes the SMS =

> as soon as it is delivered.  We should never hit a sim/me memory full
conditions.

> So I don't see how this test case even applies.

Little bit lost now. Are we speaking about the sending or receiving of
SMS?

Memory capacity exceeded applies to incoming SMS. Incoming SMS can be
stored in SIM or in ME storage. If the SMS storage for incoming SMS is
full, then the ME can inform the network that it can't handle any more
class 1/class 2 incoming SMS due to maximum memory capacity reached.
Once the user frees some memory by deleting some messages, then ME can
inform network that it is ready now to receive messages. So, I believe
this test case applies but as Pessi Pekka said we can waive this test
case.

Regards,
jeevaka

--===============1930025470506306640==--

