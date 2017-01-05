using UnityEngine;
using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

namespace Outbreak.Game.PlayerScripts
{
    public class PlayerCameraController : MonoBehaviour
    {
        private Vector3 _initPosition;
        private Vector3 velocity = Vector3.zero;

        public GameObject Target;
        public bool SmoothFollow;
        public float SmoothTime = 0.3F;

        private void Start()
        {
            if (Target == null)
                return;

            ForceStart();
        }

        public void ForceStart()
        {
            _initPosition = transform.position - Target.transform.position;
        }

        private void FixedUpdate()
        {
            if (Target == null)
                return;

            if (!SmoothFollow)
            {
                transform.position = Target.transform.position + _initPosition;
            }
            else
            {
                Vector3 targetPosition = Target.transform.position + _initPosition;
                transform.position = Vector3.SmoothDamp(transform.position, targetPosition, ref velocity, SmoothTime);
            }

            if (transform.up * -1 != LocalPlayerPhysics.Gravity.normalized)
            {
                if (LocalPlayerPhysics.Enabled)
                    iTween.RotateTo(gameObject, new Vector3(0, -180, 90), 2);
                else
                    iTween.RotateTo(gameObject, new Vector3(0, -180, 0), 2);
            }
        }
    }
}
