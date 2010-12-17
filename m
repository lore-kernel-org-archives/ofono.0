Content-Type: multipart/mixed; boundary="===============0303371321766837235=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: TODO: Network updating the emergency number list
Date: Fri, 17 Dec 2010 10:44:03 -0600
Message-ID: <4D0B9353.5060509@gmail.com>
In-Reply-To: <1292577039.29886.56.camel@r82e1wc.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0303371321766837235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 12/17/2010 03:10 AM, Tikander Petteri wrote:
> Hi,
> =

> I have investigated a little bit dynamic updating of emergency numbers
> by network. So I suggest, I'll register new notification-handler for
> '+CEN'-report in voicecall-driver. And naturally give those new
> emergency-numbers for voicecall-atom to be analyzed.
> =

> First version of network-ECC handling will enable +CEN-reporting
> statically in driver-probing. Then it listens '+CEN'-reports and after
> receiving new numbers compares those numbers with already stored numbers
> (SIM/default ECC's) and sends property-changed signal for same old good
> EmergencyNumbers-property, if new emergency numbers have been received
> from the network.
> =


Sounds good to me.

> According to TS.27007 network emergency numbers are not necessarily
> received from the same operator as currently registered, so this should
> probably also be considered in the future.
> =


Can you do me a favor and investigate what oFono's behavior should be if
we receive emergency numbers that are not relevant to the currently
registered PLMN?  We should also update the task description with the above.

> My test-modem doesn't actually support '+CEN'-reports, but I can update
> a little bit Phonesim for simulating of testing the unsolicited network
> emergency-numbers.

Sounds good.

Regards,
-Denis

--===============0303371321766837235==--

