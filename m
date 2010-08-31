Content-Type: multipart/mixed; boundary="===============9037739978753111710=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 11:07:09 -0500
Message-ID: <4C7D28AD.8030509@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A0E1B9@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9037739978753111710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 08/31/2010 10:48 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> =

> Hi Denis,
>  =

>> The original USSD API actually did look like this.  It used binary
> data
>> + dcs field.  However, we quickly found that all modems are screwed up
>> in this area.  The specification added binary PDU mode to SMS and CBS,
> but never bothered with USSD.  So all modems get this part wrong.
> =

>> Currently about the best we can do is pass UTF8 around.  If you have a
> modem that gets this part right, we'd like to hear about it.  If the
> Send USSD proactive command is =

>> not handled by the modem, then oFono will try to do its best.
> However, we make no guarantees ;)
> =

> I think its better to send the dcs and the binary data to the atom
> driver. If the modem doesn't support other than GSM 7-bit alphabet, then
> the conversion can be done in the atom driver. This way it will be
> general to any modem.

The send part is not really the problem, and can be easily done as pdu +
dcs.  However, it is the reception that is screwed up.  By convention,
all APIs in oFono must be symmetric.  E.g. what the driver sends it must
also accept.

According to 27.007, +CUSD is converted into the current character set
used by CSCS.  It is not a binary PDU at all.  So the driver now has to
fake this information...

Go ahead and send your suggested approach as a patch to this mailing
list and we can continue from there.  Just remember the symmetry part ;)

Regards,
-Denis

--===============9037739978753111710==--

