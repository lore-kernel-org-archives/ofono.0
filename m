Content-Type: multipart/mixed; boundary="===============3134791214433175123=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Reg: Memory capacity exceeded
Date: Mon, 20 Sep 2010 09:11:45 -0500
Message-ID: <4C976BA1.30600@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A51A03@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3134791214433175123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/20/2010 09:08 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
>  =

> Hi Denis,
> =

>> The thing is, oFono configures SMS for direct delivery (e.g. no SM/ME
> storage).  And even if direct delivery does not work (e.g. crappy modem
> or Class 2 / Class 3 messages) oFono still removes the SMS =

>> as soon as it is delivered.  We should never hit a sim/me memory full
> conditions.
> =

>> So I don't see how this test case even applies.
> =

> Little bit lost now. Are we speaking about the sending or receiving of
> SMS?
> =

> Memory capacity exceeded applies to incoming SMS. Incoming SMS can be
> stored in SIM or in ME storage. If the SMS storage for incoming SMS is
> full, then the ME can inform the network that it can't handle any more
> class 1/class 2 incoming SMS due to maximum memory capacity reached.
> Once the user frees some memory by deleting some messages, then ME can
> inform network that it is ready now to receive messages. So, I believe
> this test case applies but as Pessi Pekka said we can waive this test
> case.

I know exactly the case you're talking about, but as I mentioned before,
oFono does not configure the modem to store on SIM or ME.  The messages
are routed directly to oFono.  See drivers/atmodem/sms.c for more
details.  The only messages that *might* get routed to SM/ME are Class 2
/ 3 messages.  These are automatically deleted on reception by the sms
driver.

The 'memory capacity reached' can simply never happen assuming sane
hardware.

Regards,
-Denis

--===============3134791214433175123==--

