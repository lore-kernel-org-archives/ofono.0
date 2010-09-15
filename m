Content-Type: multipart/mixed; boundary="===============4886379807037743911=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 0/1] stk: Handle send ss proactive command
Date: Thu, 16 Sep 2010 01:06:21 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A79DC77@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A513AE@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4886379807037743911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi jeevaka,



>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Jeevaka.Badrappan(a)elektrobit.com
>Sent: Wednesday, September 15, 2010 8:12 PM
>To: ofono(a)ofono.org
>Subject: RE: [PATCH 0/1] stk: Handle send ss proactive command
>
>
>Hi Yang,
>
>> Below is the description:
>> This patch is to handle send ss proactive command from SIM.
>> Currently when sending a supplementary service control string via
>D-Bus, a series of functions would be called. For example, if we want to
>send a call barring activatioin string via D-Bus, these
>> functions would be called:
>ussd_initiate()->recognized_control_string()->cb_ss_control()->cb_ss_set
>_lock_callback()->cb_ss_query_next_lock()->cb_ss_query_next_lock_callbac
>k(). To handle send ss command > from SIM needs to follow the same way
>as D-Bus, so my target is to try the best to reuse these functions.
>However, currently these functions take the assumption that the calling
>is from D-Bus. My
>> solution is to introduce a data structure named "ofono_ss_req" to
>replace original "DBusMessage *" parameter.
>> Other main changes are to unify the return code of these functions and
>handle them centrally.
>
>> Comments are welcome!
>
>Following the same control flow as normal case, requires rewriting some
>of the existing functions to deal with both the cases like what you have
>done now. Isn't it better to keep it separate? So that we won't end up
>in introducing SAT specific handling in the normal use case also.
>
>Proposed solution:
>
>SS(eg: call forwarding, call barring) registers to the USSD by calling
>__ofono_ussd_ssc_register with the service code, call back
>function(normal_callback) and few other parameters. SS can also register
>to the STK by calling __ofono_ussd_ssc_register with the service code,
>call back function(stk_callback). normal_callback and stk_callback can
>handle normal and stk use case respectively. More generic handling can
>be moved to a separate function which normal_callback and stk_callback
>functions can make use of. Also parsing/matching of the service strings
>can be moved to utility. STK, USSD or anyother atoms can make use of the
>parsing/matching(of service string) utility function.
>
>Let me know your views on this.

Thank you for the comments!

But if we handle stk logic in separate functions, we would have to duplicat=
e:
In ussd.c, =

	recognized_control_string()
	recognized_passwd_change_string()
	ussd->ss_control_list
in <ss>.c:
    <ss>_ss_control() and other registered functions  // We may extract mos=
t of logic as a utility function, but we have to set the pending or the ind=
ication for stk request
    Various call back functions

I don't want to duplicate all these functions for stk, especially the two f=
unctions in ussd.c. Thinking about the case we may support at server (oFono=
 has the ability to parse incoming at command, talk with modem in its speci=
fic language, at command or proprietary protocol, and send back the respons=
e) someday, you may need to duplicate all these functions again for it. =

In my opinion, the request from D-Bus isn't so "normal". Each atom provides=
 a set of functions (services) that can be requested by others, either the =
request from D-Bus, or request from other atoms, such as stk and at server.=
 Current functions take the assumption that all the requests are all from D=
-Bus. What I want to do is just to break this assumption, and my current so=
lution is easy to be extended to support the at server case. =

What do you think about?

Regards,
-Yang

--===============4886379807037743911==--

