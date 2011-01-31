Content-Type: multipart/mixed; boundary="===============5327389496242027428=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Mon, 31 Jan 2011 14:22:23 -0600
Message-ID: <4D4719FF.3060107@gmail.com>
In-Reply-To: <1296454409.2204.6.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5327389496242027428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 01/31/2011 12:13 AM, Jukka Saunamaki wrote:
> Hello
> =

> On Thu, 2011-01-27 at 15:22 +0200, Jukka Saunamaki wrote:
>> Here is an asynchronous implementation of SIM Service Provider Name (EF-=
SPN) getter API.
>> The trick is to delay setting sim ready until spn reading is finished.
> =

> Any comments about this? =

> So, yes, it slightly delays SIM initialisation (usually SPN value should
> come from disk cache), but then netreg can use it immediately when it
> registers. =

> Alternative is still to create an asyncronous API now that there is a
> patch for safe SIM file reading.

So my main problem here is that you require the SPN a handful of times
in the phone's lifetime, more likely once.  Yet you pay the cost of
reading and delaying the initialization every time.  In my view this is
not really acceptable.

Perhaps a better approach would be to put the spn parser into simutil so
it can be shared by netreg and gprs.  Then go back to your original
proposal of delaying the gprs atom registration if provisioning is
required and SPN is needed.

Regards,
-Denis

--===============5327389496242027428==--

