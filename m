Content-Type: multipart/mixed; boundary="===============8163165831306359439=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: Re: LG VX8360 HFP non-compliance issue
Date: Wed, 29 Feb 2012 09:40:59 -0600
Message-ID: <CAB7rCTj-jVhuQ55p0OSKMAxhNigrpcdePFoorZyxSBpuBCbjQg@mail.gmail.com>
In-Reply-To: <4F471E2C.9020208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8163165831306359439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2012 at 11:20 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mike,
>
> On 02/23/2012 06:49 PM, Mike wrote:
>> I'm getting weird behaviour from an LG VX8360, connected via bluetooth
>> HFP. =C2=A0When the phone connects, I see a CallAdded signal go out over
>> dbus, despite there being no call on the phone itself. =C2=A0You can see
>> the signal below. =C2=A0The LineIdentification held the actual phone num=
ber
>> of the phone, but I replaced it with "xxxxxxxxxx". =C2=A0I also copied in
>> the initial RFCOMM communication. =C2=A0It looks to me like this phone d=
oes
>> not comply with the HFP spec in that it returns an answer to AT+CLCC
>> when there is no phone call present (and at that, an index of 0). =C2=A0=
It
>> also happens that the status is a 6, which does not appear to be a
>> valid status in HFPv1.5. =C2=A0This just happens to map to the enum
>> CALL_STATUS_DISCONNECTED, but I'm guessing this was merely
>> coincidence. =C2=A0Since the state is broadcast as disconnected, I can
>> simply ignore it in my GUI application. =C2=A0However, I'm wondering if
>> this is something that is better handled in the ofono side?
>>
>> Thanks,
>> Mike
>>
>
> Try the following patch.
>
> Regards,
> -Denis

I'm told the patch worked.  I don't have direct access to this phone
to know exactly what that means, but the issue of incorrectly
reporting a phonecall the moment the phone connects is solved.  I'm
still seeking an answer to whether or not actual phonecalls work.

Mike

--===============8163165831306359439==--

