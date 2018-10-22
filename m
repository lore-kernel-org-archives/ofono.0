Content-Type: multipart/mixed; boundary="===============1732882470532542922=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: airplane mode
Date: Mon, 22 Oct 2018 12:28:15 -0500
Message-ID: <2cf3e04b-3528-9ce0-9628-037318c592c6@gmail.com>
In-Reply-To: <CAKSBH7FEqU3PMSLu85ZPFFyQsG7Ni4cyr1Lo2o4O57SEjJhxZA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1732882470532542922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/22/2018 12:17 PM, Giacinto Cifelli wrote:
> Hi Denis,
> =

> On Mon, Oct 22, 2018 at 7:02 PM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi Giacinto,
>>
>>>> And it is fully possible to make emergency calls.  Just set Online=3DT=
rue
>>>> first.
>>>
>>> ahh, like that yes.... but then, wouldn't be better to create the
>>> voicecall atom where it belongs, in post_online ?
>>> Or this stage is never reached without a SIM? If not, what handle we
>>> have that is called for sure after AT+CFUN=3D1 ?
>>>
>>
>> Correct, without a SIM or PIN not unlocked, you'd never get to
>> post_online, even Online=3DTrue being set.
> =

> Could we think of another state?

Why would we want to?  So far all I'm hearing are issues with your =

firmware, not anything that needs to change in oFono core itself...

> I am seeing a few versions of ofono recently, and all struggle with
> things like this.
> Not everybody is up to discuss for their needs, so the problem simply
> go unnoticed.
> =


What versions of oFono you're talking about?

>>> So, that command is not well placed when the module is in CFUN=3D4.
>>> I don't know on what insane kind of modules it has been tested, but it
>>> is wrong ;)
>>
>> I would disagree.  We use CLCK to query for SIM locks, facility locks,
>> etc...
> =

> atmodem asks for AT+CLCK=3D?, and gets what it gets, despite your
> exclusive interest in sim-related parameters. In particular all
> modules return at least a subset of the following locks, all requiring
> network access to determine whether they are available or not:

"all"? Not really.  Sure the Call barring ones are a supplementary =

service feature.  But there's a reason why call_barring atom is a =

post_online one.

FD/BD do not require any network access.  They're a SIM-local feature.

Facility locks are generally an ME local feature, and also do not =

require network access.  At least that is how our modems work.  So I do =

not see any issue...

> =

>         "AO" BAOC (Barr All Outgoing Calls) (refer 3GPP TS 22.088 [6] cla=
use 1)
>         "OI" BOIC (Barr Outgoing International Calls) (refer 3GPP TS
> 22.088 [6] clause 1)
>         "OX" BOIC=E2=80=91exHC (Barr Outgoing International Calls except =
to
> Home Country) (refer 3GPP TS 22.088 [6] clause 1)
>         "AI" BAIC (Barr All Incoming Calls) (refer 3GPP TS 22.088 [6] cla=
use 2)
>         "IR" BIC=E2=80=91Roam (Barr Incoming Calls when Roaming outside t=
he
> home country) (refer 3GPP TS 22.088 [6] clause 2)
>         "NT" barr incoming calls from numbers Not stored to TA memory
>         "NM" barr incoming calls from numbers Not stored to MT memory
>         "NS" barr incoming calls from numbers Not stored to SIM/UICC memo=
ry
>         "NA" barr incoming calls from numbers Not stored in Any memory
>         "AB" All Barring services (refer 3GPP TS 22.030 [19])
> (applicable only for <mode>=3D0)
>         "AG" All outGoing barring services (refer 3GPP TS 22.030 [19])
> (applicable only for <mode>=3D0)
>         "AC" All inComing barring services (refer 3GPP TS 22.030 [19])
> (applicable only for <mode>=3D0)
>         "FD" SIM card or active application in the UICC (GSM or USIM)
> fixed dialling memory feature (if PIN2 authentication has not been
> done during the current session, PIN2 is required as <passwd>)
>         "PN" Network Personalization (refer 3GPP TS 22.022 [33])
>         "PU" network sUbset Personalization (refer 3GPP TS 22.022 [33])
>         "PP" service Provider Personalization (refer 3GPP TS 22.022 [33])
> =

> Therefore a modem cannot really honor this command in airplane mode.
> =


I disagree...

Regards,
-Denis

--===============1732882470532542922==--

