Content-Type: multipart/mixed; boundary="===============6478002875124774036=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] call-forwarding: Read/Write cfis/cphs-cff
Date: Tue, 07 Dec 2010 12:41:37 -0600
Message-ID: <4CFE7FE1.2000707@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802C40D5C@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6478002875124774036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 12/07/2010 07:59 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> Hi Denis,
>  =

>>> +	ofono_bool_t online;
>>
>> Why do you need to track this variable?  Can't you simply =

>> call ofono_modem_get_online()?
>>
> =

> This way calling of ofono_modem_get_online for each get or set request
> can be avoided.
> =


Sure, but it is doubtful you really need to 'optimize' those cases.  The
code is way cleaner without it in my opinion.

Regards,
-Denis

--===============6478002875124774036==--

