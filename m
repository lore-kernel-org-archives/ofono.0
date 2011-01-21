Content-Type: multipart/mixed; boundary="===============2114365724369313642=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH] doc: Add modem Type property
Date: Fri, 21 Jan 2011 13:48:43 -0800
Message-ID: <4D39FF3B.2090902@nokia.com>
In-Reply-To: <4D39F4F2.5090807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2114365724369313642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/21/2011 01:04 PM, ext Denis Kenzior wrote:
> Hi Lei,
>
>>>> +        string Type [readonly, optional, experimental]
>>>> +
>>>> +            String representing the type of the modem device.
>>>> +
>>>> +            The possible values are:
>>>> +                "gsm"     Modem supports one or more of the 3GPP
>>>> +                    family of technologies including GSM,
>>>> +                    EDGE, UMTS, HSPA, LTE.
>>>> +                "cdma"  Modem supports one or more of the 3GPP2
>>>> +                    family of technologies including CDMA 1x,
>>>> +                    EVDO.
>>>> +                "hfp"    Bluetooth hands-free profile (HFP) modem
>>>> +
>>>
>>> So one pointed question:
>>>
>>> How are we planning to support dual-mode devices with this property?  I
>>> believe during the CDMA workshop we decided that the clients should
>>> simply look at the set of interfaces, not a semi-static property...
>>
>> We understand that the decision during the CDMA workshop but as we
>> explained one use case in the cover letter
>> (http://lists.ofono.org/pipermail/ofono/2011-January/007890.html) for
>> this RFC, there will be cases where atom's D-Bus I/F is not suitable (or
>> as a reliable way) for telling what is current mode (CDMA or GSM). E.g.,
>> in the case of retrieving serial number from modem. Currently both CDMA
>> and GSM shares the same I/F (ofono.org.modem) rather than having
>> separate (ofono.org.cdma.modem). And, further if no other atom has been
>> instantiated, then, there will be no other way to tell which mode (CDMA
>> or GSM) the modem is. And, further for displaying serial number, upper
>> layer will need to know it is CDMA or GSM. In case of CDMA, the serial
>> number is MEID and GSM it is IMEI. As explained in cover letter, we
>> anticipate more cases like this.
>
> So let us say I have a dual-mode modem.  Are there now two serial
> numbers? One for MEID and one for IMEI?  Are there now two
> Manufacturers? Two Revisions?

Try to clarify what you try to ask first. Let's start with the dual-mode =

case where the modem is integrated modem (one piece of HW) where it =

supports both CDMA and GSM. Then, there is case where the phone actually =

has both MEID and IMEI. And, these two numbers are actually the same =

(note, per IMEI's assignment there is a pre-arranged segment for this =

kind of world phone). And, in which case, one manufacture, one revision. =

Per the other thread, in which case the "Type" will be something like =

"gsm_cdma".
Of course, there can be case where two physical modems are in the device =

in which case there will be two separate serial numbers and two =

manufacturers and revisions. I am assuming you are not asking for this case.

Again, the problem we try to solve is single mode case.

>
> Regards,
> -Denis

Regards,
- Lei

--===============2114365724369313642==--

