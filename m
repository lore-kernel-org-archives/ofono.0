Content-Type: multipart/mixed; boundary="===============1261388634156586642=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 0/1] stk: Handle send ss proactive command
Date: Wed, 15 Sep 2010 15:12:22 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A513AE@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4732A73BF78@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1261388634156586642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Yang,

> Below is the description:
> This patch is to handle send ss proactive command from SIM. =

> Currently when sending a supplementary service control string via
D-Bus, a series of functions would be called. For example, if we want to
send a call barring activatioin string via D-Bus, these =

> functions would be called:
ussd_initiate()->recognized_control_string()->cb_ss_control()->cb_ss_set
_lock_callback()->cb_ss_query_next_lock()->cb_ss_query_next_lock_callbac
k(). To handle send ss command > from SIM needs to follow the same way
as D-Bus, so my target is to try the best to reuse these functions.
However, currently these functions take the assumption that the calling
is from D-Bus. My =

> solution is to introduce a data structure named "ofono_ss_req" to
replace original "DBusMessage *" parameter. =

> Other main changes are to unify the return code of these functions and
handle them centrally.

> Comments are welcome!

Following the same control flow as normal case, requires rewriting some
of the existing functions to deal with both the cases like what you have
done now. Isn't it better to keep it separate? So that we won't end up
in introducing SAT specific handling in the normal use case also.

Proposed solution:

SS(eg: call forwarding, call barring) registers to the USSD by calling
__ofono_ussd_ssc_register with the service code, call back
function(normal_callback) and few other parameters. SS can also register
to the STK by calling __ofono_ussd_ssc_register with the service code,
call back function(stk_callback). normal_callback and stk_callback can
handle normal and stk use case respectively. More generic handling can
be moved to a separate function which normal_callback and stk_callback
functions can make use of. Also parsing/matching of the service strings
can be moved to utility. STK, USSD or anyother atoms can make use of the
parsing/matching(of service string) utility function.

Let me know your views on this.

Thanks and Regards,
jeevaka

--===============1261388634156586642==--

