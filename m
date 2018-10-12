Content-Type: multipart/mixed; boundary="===============8655389641576974721=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 4/6] src/modem: notify lte driver before going online
Date: Fri, 12 Oct 2018 08:17:46 +0200
Message-ID: <00e1adb6-6a3a-f6ca-82b8-454ef14085e4@southpole.se>
In-Reply-To: <CAKSBH7GmbNCQFxG21gEi9Mw7HSicib8W3nNq2toq9QtFWrnmJA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8655389641576974721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/10/18 05:04, Giacinto Cifelli wrote:
> Hi,
>
> On Thu, Oct 11, 2018 at 10:19 PM Jonas Bonn <jonas@southpole.se> wrote:
>>
>>
>> On 10/10/18 08:54, Giacinto Cifelli wrote:
>>> ---
>>>    src/modem.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/src/modem.c b/src/modem.c
>>> index 9e254482..74dbe7ad 100644
>>> --- a/src/modem.c
>>> +++ b/src/modem.c
>>> @@ -729,6 +729,8 @@ static void sim_state_watch(enum ofono_sim_state ne=
w_state, void *user)
>>>        case OFONO_SIM_STATE_READY:
>>>                modem_change_state(modem, MODEM_STATE_OFFLINE);
>>>
>>> +             ofono_lte_set_reg_info(modem);
>>> +
>> modem_change_state(...OFFLINE) results in the post_sim() implementation
>> being called.  The drivers that implement the lte atom all call
>> ofono_lte_create() there.
>>
>> Your .._set_reg_info function checks for the existence of the atom and
>> does some work.  As such, why not just merge the contents of
>> ofono_lte_set_reg_info() into the at_lte_probe function instead... from
>> there, it's more obvious what's going on.
> The point is that the function must be called before set_online
> (following), and not after post_sim, even if they happen to be
> together.

set_online only happens in the following line if the modem is "always =

online", which is generally not the case.=C2=A0 For other modems, set_onlin=
e =

happens elsewhere.

> This is how it works for gprs-context: before activating the context,
> apn and auth are set.
>
> It isn't so obvious to me that the probe function does the work. It is
> in general the first one to be called, then there is a chance to set
> the properties one by one, and eventually they are transferred to the
> modem.

Between "enable" and "online", you have a window to change the settings.

For modems that are "always online", you pretty much have to go =

"enabled/online", perhaps failing to do so(?), change the settings, =

"disable" and "reenable" the modem.=C2=A0 Ugly, yes, but that's the way =

things look right now.

Twiddling the LTE settings just results in context reconfiguration =

(CGDCONT)... this, presumably, does not have any effect on any already =

established context... correct me if I'm wrong.=C2=A0 As such, the changes =

don't really take effect until you've gone offline/online again, anyway.

/Jonas

--===============8655389641576974721==--

