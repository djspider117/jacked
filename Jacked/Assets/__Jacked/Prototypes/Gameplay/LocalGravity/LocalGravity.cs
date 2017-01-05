using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class LocalGravity : MonoBehaviour
{
    private List<Rigidbody> _targets;

    public bool UseGlobalGravity;
    public bool Is0G;
    public bool UseLocalGravity;
    public Vector3 LocalGravityVector;

    void Start()
    {
        _targets = new List<Rigidbody>();
        if (Is0G)
            UseGlobalGravity = false;
    }

    private void FixedUpdate()
    {
        if (UseGlobalGravity)
        {
            Is0G = false;
            UseLocalGravity = false;
            return;
        }

        var anitGrav = Physics.gravity * -1;

        if (Is0G)
        {
            UseLocalGravity = false;
            foreach (var x in _targets)
            {
                x.AddForce(anitGrav);
            }
            return;
        }

        if (UseLocalGravity)
        {
            LocalPlayerPhysics.Gravity = LocalGravityVector;
            foreach (var x in _targets)
            {
                x.AddForce(anitGrav + LocalGravityVector);
            }
        }
    }

    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
            LocalPlayerPhysics.Enabled = UseLocalGravity;

        var rbd = other.gameObject.GetComponent<Rigidbody>();
        if (rbd != null)
            _targets.Add(rbd);
    }

    public void OnTriggerExit(Collider other)
    {
        var rbd = other.gameObject.GetComponent<Rigidbody>();
        if (rbd != null && _targets.Contains(rbd))
            _targets.Remove(rbd);
    }
}

public class LocalPlayerPhysics
{
    public static bool Enabled;
    public static Vector3 Gravity;
}
