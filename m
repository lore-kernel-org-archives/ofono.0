Content-Type: multipart/mixed; boundary="===============6761082121520946817=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] stk: Add null pointer check
Date: Fri, 25 Feb 2011 14:28:11 +0100
Message-ID: <AANLkTik8FOtSTWfyATp_eXV-7Prp9+Ao3BA1NBNoJMnm@mail.gmail.com>
In-Reply-To: <1298639095.5082.20.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6761082121520946817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 25 February 2011 14:04, Lasse Kunnasluoto
<lasse.kunnasluoto@tieto.com> wrote:
> On Fri, 2011-02-25 at 14:39 +0200, Andrzej Zaborowski wrote:
>> On 25 February 2011 11:39, Lasse Kunnasluoto <lasse.kunnasluoto@tieto.=
com> wrote:
>> > Fixes a crash when SIM Session End is received while waiting for user =
response to SELECT ITEM command.
>>
>> Can you post the ofono debug log for example? =C2=A0It sounds like
>> something else is wrong because stk_respond should not be called when
>> the session is ended by the card.
>
> Sure, log below.
>
> For me it looks like modem times out after 1 min if no response given. I
> don't think the session was terminated by SIM. Usually SIM cards wait
> for TERMINAL RESPONSE basically forever. SIM has no mechanism to
> terminate ongoing proactive command (well, except reset itself)

Thanks for the log.

Even if it is the modem timing out, our assumption was that no
TERMINAL RESPONSE is wanted after the timeout (*STKEND).  So I think
the following would be a better fix:

diff --git a/src/stk.c b/src/stk.c
index bc46b2f..c4e988b 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2514,6 +2514,7 @@ static void stk_proactive_command_cancel(struct
ofono_stk *stk)
                stk_command_free(stk->pending_cmd);
                stk->pending_cmd =3D NULL;
                stk->cancel_cmd =3D NULL;
+               stk->respond_on_exit =3D FALSE;
        }
 }

Alternatively this line can be added in stk_request_cancel

Best regards

--===============6761082121520946817==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="reset-respond_on_exit.patch"

ZGlmZiAtLWdpdCBhL3NyYy9zdGsuYyBiL3NyYy9zdGsuYwppbmRleCBiYzQ2YjJmLi5jNGU5ODhi
IDEwMDY0NAotLS0gYS9zcmMvc3RrLmMKKysrIGIvc3JjL3N0ay5jCkBAIC0yNTE0LDYgKzI1MTQs
NyBAQCBzdGF0aWMgdm9pZCBzdGtfcHJvYWN0aXZlX2NvbW1hbmRfY2FuY2VsKHN0cnVjdCBvZm9u
b19zdGsgKnN0aykKIAkJc3RrX2NvbW1hbmRfZnJlZShzdGstPnBlbmRpbmdfY21kKTsKIAkJc3Rr
LT5wZW5kaW5nX2NtZCA9IE5VTEw7CiAJCXN0ay0+Y2FuY2VsX2NtZCA9IE5VTEw7CisJCXN0ay0+
cmVzcG9uZF9vbl9leGl0ID0gRkFMU0U7CiAJfQogfQogCg==

--===============6761082121520946817==--

