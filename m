Content-Type: multipart/mixed; boundary="===============6648867815169054702=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] sim: query remaining pin retries
Date: Tue, 04 Jan 2011 11:29:37 -0600
Message-ID: <4D235901.60808@gmail.com>
In-Reply-To: <AANLkTimmSTmbY-GyBPa_hisU7E59_6S9r+ZP5JE9wLY3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6648867815169054702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 01/04/2011 11:26 AM, Lucas De Marchi wrote:
> Hi Denis,
> =

> On Tue, Jan 4, 2011 at 3:13 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>> Hi Lucas,
>>
>> On 01/04/2011 07:06 AM, Lucas De Marchi wrote:
>>> @@ -62,6 +62,8 @@ struct ofono_sim {
>>>       enum ofono_sim_password_type pin_type;
>>>       gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PI=
Ns */
>>>
>>> +     GSList *pin_retries;
>>> +
>>
>> Are you forgetting to free the pin_retries array when the sim is removed
>> or the sim atom is destroyed?
>>
> =

> Yes, I forgot. Since I cannot have G* types on headers, I'll store a
> ofono_sim_pin_retry **retries here and convert the code so the list
> will not be necessary. Is this ok?

Should be fine.  See how it works out.  Just remember that the drivers
are free to return arrays on the stack, so you cannot assume ownership.

Regards,
-Denis

--===============6648867815169054702==--

